//
//  DetailsShowViewModel.swift
//  RadioPlus
//
//  Created by Derouiche Elyes on 21/12/2022.
//

import Foundation

import Combine

protocol DetailsShowViewModelProtocol: HasShowRepositoryProtocol {
    
}

class DetailsShowViewModel: ObservableObject, DetailsShowViewModelProtocol {
    
    var showRepository: ShowRepositoryProtocol
    
    var show: Show
    
    var title: String
    var standFirst: String
    var websiteUrl: String
    var diffusionConnection: Diffusions = []
    
    @Published
    var cancellable = Set<AnyCancellable>()
    
    @Published
    var renderedContent: [DetailsShowCategoryView] = []
    
    typealias Dependencies = HasShowRepositoryProtocol
    
    init(dependencies: Dependencies, show: Show) {
        self.showRepository = dependencies.showRepository
        
        self.show = show
        self.title = show.title ?? ""
        self.standFirst = show.standFirst ?? ""
        self.websiteUrl = show.url ?? ""
        self.diffusionConnection = show.diffusionsConnection.map { $0.edges.flatMap { $0.compactMap { $0.node } } ?? [] } ?? []
    }
    
    func prepareView() {
        self.renderedContent.append(contentsOf: [.init(type: .info(title: "Title", content: self.title)),
                                                 .init(type: .info(title: "Stand first", content: self.standFirst))]
        )
        
        if !self.diffusionConnection.isEmpty {
            self.renderedContent.append(.init(type: .diffusion(title: "Diffusion", diffusions: self.diffusionConnection, viewType: .fullwidthCard)))
        }
    }
}
