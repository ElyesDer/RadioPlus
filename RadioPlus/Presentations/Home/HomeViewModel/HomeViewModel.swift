//
//  HomeViewModel.swift
//  RadioPlus
//
//  Created by Derouiche Elyes on 20/12/2022.
//

import Foundation
import SwiftUI

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
    
//    @Published
//    var brands: Brands = []
//
//    @Published
//    var shows: Shows = []
//
//    @Published
//    var live: Live? = nil
//
//    @Published
//    var grids: Grids = []
    
    @MainActor
    @Published
    var content: [HomeCategoryView] = []
    
    typealias Dependencies = HasGridRepositoryProtocol & HasShowRepositoryProtocol & HasLiveRepositoryProtocol & HasBrandRepositoryProtocol
    
    init(dependencies: Dependencies) {
        self.showRepository = dependencies.showRepository
        self.gridRepository = dependencies.gridRepository
        self.brandRepository = dependencies.brandRepository
        self.liveRepository = dependencies.liveRepository
    }
    
    func prepareHome() {
        Task { @MainActor in
            let shows = await fetchShows(for: .FRANCEBLEU, first: 10)
            content.append(.shows(title: "All FRANCEBLEU shows", categoryMode: .fullwidthCard, shows: shows))
        }
    }
    
    func fetchGrid(start: Date, end: Date, for station: Stations) async {
        do {
            let startDate = start.yesterdayDate()!.posixTime()
            let endDate = end.posixTime()
            let station: Stations = .FRANCEBLEU
            let grids = try await gridRepository.getGrid(start: startDate, end: endDate, station: station)
        } catch {
            await handleError(error: error)
        }
    }
    
    func fetchLive(for station: Stations) async {
        do {
            let live = try await liveRepository.getLive(for: station)
        } catch {
            await handleError(error: error)
        }
    }
    
    func fetchShows(for station: Stations, first: Int) async -> Shows {
        do {
            let showsResponse = try await showRepository.getShows(for: station, first: first)
            return showsResponse.shows.edges.flatMap {
                $0.compactMap {
                    $0.node
                }
            } ?? []
        } catch {
            await handleError(error: error)
        }
        
        return []
    }
    
    func fetchBrands() async {
        do {
            let brands = try await brandRepository.getAllBrands()
        } catch {
            await handleError(error: error)
        }
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
