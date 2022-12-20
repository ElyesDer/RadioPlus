//
//  ShowRepository.swift
//  RadioPlus
//
//  Created by Derouiche Elyes on 20/12/2022.
//

import Foundation

protocol HasShowRepositoryProtocol {
    var showRepository: ShowRepositoryProtocol { get }
}

protocol ShowRepositoryProtocol {
    func getShows(for station: Stations, first: Int) async throws -> ShowsResponse
}

class ShowRepository: ShowRepositoryProtocol {
    
    private let requester: DataServiceProviderProtocol
    
    internal init(requester: DataServiceProviderProtocol) {
        self.requester = requester
    }
    
    func getShows(for station: Stations, first: Int) async throws -> ShowsResponse {
        let operation: ShowRemoteOperation = .getShows(with: .init(station: station, first: first))
        return try await requester.performOperation(operation)
    }
}
