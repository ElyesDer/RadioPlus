//
//  BrandRepository.swift
//  RadioPlus
//
//  Created by Derouiche Elyes on 20/12/2022.
//

import Foundation

protocol BrandRepositoryProtocol {
    func getAllBrands() async throws -> BrandResponse
}

class BrandRepository: BrandRepositoryProtocol {
    
    private let requester: DataServiceProviderProtocol
    private let provider: NetworkProvider
    
    internal init(requester: DataServiceProviderProtocol, provider: NetworkProvider) {
        self.requester = requester
        self.provider = provider
    }
    
    func getAllBrands() async throws -> BrandResponse {
        let operation: BrandRemoteOperation = .getAllBrands()
        return try await requester.performOperation(operation)
    }
}
