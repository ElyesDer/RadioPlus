//
//  LiveRemoteOperations.swift
//  RadioPlus
//
//  Created by Derouiche Elyes on 20/12/2022.
//

import Foundation

struct LiveRemoteOperation: GraphQLOperationProtocol {
    typealias Input = LiveQuery
    typealias Output = LiveResponse
    
    var input: LiveQuery
    
    var operationString: String
    
    var method: HTTPMethods = .post
    
    var endURL: APIProvider = .api
    
    static func getLive(with query: LiveQuery) -> Self {
        LiveRemoteOperation(input: query,
                            operationString: """
                    query getLive($station: StationsEnum!) {
                          live(station: $station) {
                            show {
                              id
                              ... on DiffusionStep {
                                id
                                diffusion {
                                  id
                                  title
                                  standFirst
                                  url
                                  published_date
                                  podcastEpisode {
                                    id
                                    title
                                    url
                                    created
                                    duration
                                  }
                                }
                              }
                              ... on BlankStep {
                                id
                                title
                              }
                            }
                            program {
                              id
                              ... on DiffusionStep {
                                id
                                diffusion {
                                  id
                                  title
                                  standFirst
                                  url
                                  published_date
                                  podcastEpisode {
                                    id
                                    title
                                    url
                                    created
                                    duration
                                  }
                                }
                              }
                              ... on BlankStep {
                                id
                                title
                              }
                            }
                            song {
                              id
                              start
                              end
                              track {
                                id
                                title
                                albumTitle
                                discNumber
                                trackNumber
                              }
                            }
                          }
                    }
                """)
    }
}
