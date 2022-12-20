//
//  LiveRepository.swift
//  RadioPlus
//
//  Created by Derouiche Elyes on 20/12/2022.
//

import Foundation

protocol HasLiveRepositoryProtocol {
    var liveRepository: LiveRepositoryProtocol { get }
}

protocol LiveRepositoryProtocol {
    func getLive(for station: Stations) async throws -> Live?
}

class LiveRepository: LiveRepositoryProtocol {
    
    private let requester: DataServiceProviderProtocol
    
    internal init(requester: DataServiceProviderProtocol) {
        self.requester = requester
    }
    
    func getLive(for station: Stations) async throws -> Live? {
        let operation: LiveRemoteOperation = .getLive(with: .init(station: station))
        return try await requester.performOperation(operation).live
    }
}
