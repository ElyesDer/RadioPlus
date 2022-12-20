//
//  BrandRepository.swift
//  RadioPlus
//
//  Created by Derouiche Elyes on 20/12/2022.
//

import Foundation

protocol HasBrandRepositoryProtocol {
    var brandRepository: BrandRepositoryProtocol { get }
}

protocol BrandRepositoryProtocol {
    func getAllBrands() async throws -> Brands
}

class BrandRepository: BrandRepositoryProtocol {
    
    private let requester: DataServiceProviderProtocol
    
    internal init(requester: DataServiceProviderProtocol) {
        self.requester = requester
    }
    
    func getAllBrands() async throws -> Brands {
        let operation: BrandRemoteOperation = .getAllBrands()
        return try await requester.performOperation(operation).brands
    }
}
