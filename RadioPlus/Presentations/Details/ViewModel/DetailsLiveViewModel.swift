//
//  DetailsViewModel.swift
//  RadioPlus
//
//  Created by Derouiche Elyes on 21/12/2022.
//

import Foundation
import Combine

protocol DetailsLiveViewModelProtocol: HasLiveRepositoryProtocol {
    
}

class DetailsLiveViewModel: ObservableObject, DetailsLiveViewModelProtocol {
    
    var liveRepository: LiveRepositoryProtocol
    
    var liveShow: Live
    
    @Published var title: String
    @Published var standFirst: String
    @Published var moreInfoUrl: String
    @Published var currentlyPlaying: String
    
    @Published
    var cancellable = Set<AnyCancellable>()
    
    typealias Dependencies = HasLiveRepositoryProtocol
    
    init(dependencies: Dependencies, live: Live) {
        self.liveRepository = dependencies.liveRepository
        
        self.liveShow = live
        self.title = live.show?.title ?? ""
        self.standFirst = live.program?.diffusion?.standFirst ?? ""
        self.moreInfoUrl = live.program?.diffusion?.url ?? ""
        self.currentlyPlaying = live.song ?? ""
    }
}
