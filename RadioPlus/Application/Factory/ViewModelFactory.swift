//
//  ViewModelFactory.swift
//  RadioPlus
//
//  Created by Derouiche Elyes on 20/12/2022.
//

import Foundation

protocol ViewModelFactoryProtocol: HasDataServiceProviderProtocol, HasShowRepositoryProtocol, HasGridRepositoryProtocol, HasLiveRepositoryProtocol, HasBrandRepositoryProtocol {
    
}

class ViewModelFactory: ObservableObject, ViewModelFactoryProtocol {
    
    var dataServiceProvider: DataServiceProviderProtocol
    var showRepository: ShowRepositoryProtocol
    var gridRepository: GridRepositoryProtocol
    var liveRepository: LiveRepositoryProtocol
    var brandRepository: BrandRepositoryProtocol
    
    init() {
        self.dataServiceProvider = Requester()
        self.showRepository = ShowRepository(requester: self.dataServiceProvider)
        self.gridRepository = GridRepository(requester: self.dataServiceProvider)
        self.liveRepository = LiveRepository(requester: self.dataServiceProvider)
        self.brandRepository = BrandRepository(requester: self.dataServiceProvider)
    }
    
    func buildHomeViewModel() -> HomeViewModel {
        return HomeViewModel(dependencies: self)
    }
    
    func buildLiveViewModel(live: Live) -> DetailsLiveViewModel {
        return DetailsLiveViewModel(dependencies: self, live: live)
    }
    
    
    func buildBrandViewModel(brand: Brand) -> DetailsBrandViewModel {
        return DetailsBrandViewModel(dependencies: self, brand: brand)
    }
    
    func buildShowViewModel(show: Show) -> DetailsShowViewModel {
        return DetailsShowViewModel(dependencies: self, show: show)
    }
    
}
