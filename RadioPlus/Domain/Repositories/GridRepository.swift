//
//  GridRepository.swift
//  RadioPlus
//
//  Created by Derouiche Elyes on 19/12/2022.
//

import Foundation

protocol GridRepositoryProtocol {
    func getGrid(start: Int32, end: Int32, station: Stations) async throws -> GridResponse
}

class GridRepository: GridRepositoryProtocol {
    
    private let requester: DataServiceProviderProtocol
    private let provider: NetworkProvider
    
    internal init(requester: DataServiceProviderProtocol, provider: NetworkProvider) {
        self.requester = requester
        self.provider = provider
    }
    
    func getGrid(start: Int32, end: Int32, station: Stations) async throws -> GridResponse {
        let operation: GridRemoteOperations = .getGrid(query: .init(start: start, end: end, station: station))
        return try await requester.performOperation(operation)
    }
}
