//
//  TestOperation.swift
//  RadioPlus
//
//  Created by Derouiche Elyes on 20/12/2022.
//

import Foundation

struct GridRemoteOperations: GraphQLOperationProtocol {
    
    typealias Input = GridQuery
    typealias Output = GridResponse
    
    var input: GridQuery
    var operationString: String
    
    var token: String = APIProvider.token
    var method: HTTPMethods = .post
    var endURL: APIProvider = .api
    
    static func getGrid(query: GridQuery) -> Self {
        GridRemoteOperations(input: query,
                             operationString: """
                    query getGrid($start: Int, $end: Int, $station: StationsEnum!) {
                      grid(start: $start, end: $end, station: $station, includeTracks: false) {
                        ... on DiffusionStep {
                          id
                          diffusion {
                            id
                            title
                            standFirst
                            url
                            published_date
                          }
                        }
                      }
                    }
                """)
    }
}
