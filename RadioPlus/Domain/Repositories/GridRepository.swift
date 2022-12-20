//
//  GridRepository.swift
//  RadioPlus
//
//  Created by Derouiche Elyes on 19/12/2022.
//

import Foundation


protocol HasGridRepositoryProtocol {
    var gridRepository: GridRepositoryProtocol { get }
}

protocol GridRepositoryProtocol {
    func getGrid(start: Int32, end: Int32, station: Stations) async throws -> Grids
}

class GridRepository: GridRepositoryProtocol {
    
    private let requester: DataServiceProviderProtocol
    
    internal init(requester: DataServiceProviderProtocol) {
        self.requester = requester
    }
    
    func getGrid(start: Int32, end: Int32, station: Stations) async throws -> Grids {
        let operation: GridRemoteOperations = .getGrid(query: .init(start: start, end: end, station: station))
        return try await requester.performOperation(operation).grid
    }
}
