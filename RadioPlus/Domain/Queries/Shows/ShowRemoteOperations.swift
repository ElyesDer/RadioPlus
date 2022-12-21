//
//  ShowRemoteOperations.swift
//  RadioPlus
//
//  Created by Derouiche Elyes on 20/12/2022.
//

import Foundation

struct ShowRemoteOperation: GraphQLOperationProtocol {
    
    typealias Input = ShowQuery
    typealias Output = ShowsResponse
    
    var input: ShowQuery
    
    var operationString: String
    
    var method: HTTPMethods = .post
    
    var endURL: APIProvider = .api
    
    static func getShows(with query: ShowQuery) -> Self {
        ShowRemoteOperation(input: query,
                            operationString: """
                            query getShows($station: StationsEnum!, $first: Int) {
                              shows(station: $station, first: $first) {
                                edges {
                                  cursor
                                  node {
                                    id
                                    title
                                    standFirst
                                    url
                                    diffusionsConnection {
                                      edges {
                                        node {
                                          id
                                          title
                                          standFirst
                                          url
                                          personalitiesConnection {
                                            edges {
                                              relation
                                              info
                                              node {
                                                id
                                                name
                                              }
                                            }
                                          }
                                        }
                                      }
                                    }
                                  }
                                }
                              }
                            }
                            """)
    }
}
