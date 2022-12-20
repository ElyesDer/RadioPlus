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
    
//    typealias Dependencies = HasDataServiceProviderProtocol & HasShowRepositoryProtocol & HasGridRepositoryProtocol & HasLiveRepositoryProtocol & HasBrandRepositoryProtocol
//    
//    var dependencies: Dependencies
    
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
}
