//
//  DetailsBrandViewModel.swift
//  RadioPlus
//
//  Created by Derouiche Elyes on 21/12/2022.
//

import Foundation
import Combine

protocol DetailsBrandViewModelProtocol: HasBrandRepositoryProtocol {
    
}

class DetailsBrandViewModel: ObservableObject, DetailsBrandViewModelProtocol {
    
    var brandRepository: BrandRepositoryProtocol
    
    var brand: Brand
    
    @Published var title: String
    @Published var baseline: String
    @Published var description: String
    @Published var websiteUrl: String
    @Published var liveStream: String?
    @Published var localRadios: Radios = []
    @Published var webRadios: Radios = []
    
    @Published
    var cancellable = Set<AnyCancellable>()
    
    @Published
    var renderedContent: [DetailsBrandCategoryView] = []
    
    typealias Dependencies = HasBrandRepositoryProtocol
    
    init(dependencies: Dependencies, brand: Brand) {
        self.brandRepository = dependencies.brandRepository
        
        self.brand = brand
        self.title = brand.title ?? ""
        self.baseline = brand.baseline ?? ""
        self.description = brand.brandDescription ?? ""
        self.websiteUrl = brand.websiteURL ?? ""
        self.liveStream = brand.liveStream
        self.localRadios = brand.localRadios ?? []
        self.webRadios = brand.webRadios ?? []
    }
    
    func prepareView() {
        self.renderedContent.append(contentsOf: [.init(type: .info(title: "Baseline", content: self.baseline)),
                                                 .init(type: .info(title: "Description", content: self.description))]
        )
        
        if !self.localRadios.isEmpty {
            self.renderedContent.append(.init(type: .radios(title: "Local radios", radios: self.localRadios, viewType: .verticalCard)))
        }
        
        if !self.webRadios.isEmpty {
            self.renderedContent.append(.init(type: .radios(title: "Web radios", radios: self.webRadios, viewType: .verticalCard)))
        }
    }
}
