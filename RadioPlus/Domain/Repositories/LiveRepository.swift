//
//  LiveRepository.swift
//  RadioPlus
//
//  Created by Derouiche Elyes on 20/12/2022.
//

import Foundation

protocol LiveRepositoryProtocol {
    func getLive(for station: Stations) async throws -> LiveResponse
}

class LiveRepository: LiveRepositoryProtocol {
    
    private let requester: DataServiceProviderProtocol
    private let provider: NetworkProvider
    
    internal init(requester: DataServiceProviderProtocol, provider: NetworkProvider) {
        self.requester = requester
        self.provider = provider
    }
    
    func getLive(for station: Stations) async throws -> LiveResponse {
        let operation: LiveRemoteOperation = .getLive(with: .init(station: station))
        return try await requester.performOperation(operation)
    }
}
