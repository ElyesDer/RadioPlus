//
//  GridRepository.swift
//  RadioPlus
//
//  Created by Derouiche Elyes on 19/12/2022.
//

import Foundation

protocol GridRepositoryProtocol {
    func getGrid(grid: GridRemoteOperations) async throws -> GridResponse
}

class GridRepository: GridRepositoryProtocol {
    
    private let requester: DataServiceProviderProtocol
    private let provider: NetworkProvider
    
    internal init(requester: DataServiceProviderProtocol, provider: NetworkProvider) {
        self.requester = requester
        self.provider = provider
    }
    
    func getGrid(grid: GridRemoteOperations) async throws -> GridResponse {
        try await requester.performOperation(grid)
    }
}
