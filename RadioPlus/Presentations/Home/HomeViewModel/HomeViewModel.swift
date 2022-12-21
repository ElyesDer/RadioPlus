//
//  HomeViewModel.swift
//  RadioPlus
//
//  Created by Derouiche Elyes on 20/12/2022.
//

import Foundation
import SwiftUI
import Combine

enum HomeViewModelState {
    case loading
    case idle
    case error(String)
}

protocol HomeViewModelProtocol: HasShowRepositoryProtocol, HasGridRepositoryProtocol, HasLiveRepositoryProtocol, HasBrandRepositoryProtocol {
    var viewState: HomeViewModelState { get }
}

class HomeViewModel: ObservableObject, HomeViewModelProtocol {
    
    var gridRepository: GridRepositoryProtocol
    var liveRepository: LiveRepositoryProtocol
    var brandRepository: BrandRepositoryProtocol
    var showRepository: ShowRepositoryProtocol
    
    @MainActor
    @Published
    var viewState: HomeViewModelState = .idle
    
    var brands: Brands = []
    var shows: Shows = []
    var live: Live? = nil
    var grids: Grids = []
    
    var content: [HomeCategoryView] = [] {
        didSet {
            renderedContent = content
        }
    }
    
    @Published
    var renderedContent: [HomeCategoryView] = []
    
    @Published
    var searchText: String = ""
    
    @Published
    var cancellable = Set<AnyCancellable>()
    
    typealias Dependencies = HasGridRepositoryProtocol & HasShowRepositoryProtocol & HasLiveRepositoryProtocol & HasBrandRepositoryProtocol
    
    init(dependencies: Dependencies) {
        self.showRepository = dependencies.showRepository
        self.gridRepository = dependencies.gridRepository
        self.brandRepository = dependencies.brandRepository
        self.liveRepository = dependencies.liveRepository
        
        setupSearchBinding()
        
        prepareHome()
    }
    
    func setupSearchBinding() {
        $searchText
            .debounce(for: .milliseconds(200), scheduler: RunLoop.main)
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { searchText in
                if searchText.isEmpty {
                    self.renderedContent = self.content
                    return
                }
                
                self.renderedContent = self.content.filter { !$0.getSearchableContent().filter { $0.lowercased().contains(searchText.lowercased()) }.isEmpty }
                
            }.store(in: &cancellable)
    }
    
    func prepareHome() {
        Task { @MainActor in
            await [Stations.FIP, .FRANCECULTURE, .FRANCEINTER, .FRANCEMUSIQUE, .FRANCECULTURE].asyncForEach { station in
                let shows = await fetchShows(for: station, first: 10)
                if !shows.isEmpty {
                    content.append(.init(type: .shows(title: "\(station) shows", categoryMode: .verticalCard, shows: shows)))
                }
            }
        }
        
        Task { @MainActor in
            if let randomStation = Stations.allCases.randomElement(), let live = await fetchLive(for: randomStation) {
                content.append(.init(type: .live(title: "Currently live @ \(randomStation.rawValue.capitalized)", live: live)))
            }
        }
        
        Task { @MainActor in
            let brands = await fetchBrands()
            if !brands.isEmpty {
                content.append(.init(type: .brand(title: "Brands", brands: brands)))
            }
        }
    }
    
    func fetchGrid(start: Date, end: Date, for station: Stations) async -> Grids {
        do {
            let startDate = start.yesterdayDate()!.posixTime()
            let endDate = end.posixTime()
            let station: Stations = station
            grids = try await gridRepository.getGrid(start: startDate, end: endDate, station: station)
            return grids
        } catch {
            await handleError(error: error)
        }
        return []
    }
    
    func fetchLive(for station: Stations) async -> Live? {
        do {
            live = try await liveRepository.getLive(for: station)
            return live
        } catch {
            await handleError(error: error)
        }
        return nil
    }
    
    func fetchShows(for station: Stations, first: Int) async -> Shows {
        do {
            shows = try await showRepository.getShows(for: station, first: first).shows.edges.flatMap {
                $0.compactMap {
                    $0.node
                }
            } ?? []
            return shows
        } catch {
            await handleError(error: error)
        }
        return []
    }
    
    func fetchBrands() async -> Brands {
        do {
            brands = try await brandRepository.getAllBrands()
            return brands
        } catch {
            await handleError(error: error)
        }
        return []
    }
    
    @MainActor
    private func handleError(error: Error) {
        if case .error(_) = viewState { return }
        if let error = error as? Requester.ServiceError {
            self.viewState = .error(error.localizedDescription)
        } else {
            viewState = .error("Could not fetch brands")
        }
    }
    
}
