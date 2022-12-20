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
                            {
                              brands {
                                id
                                title
                                baseline
                                description
                                websiteUrl
                                liveStream
                                localRadios {
                                  id
                                  title
                                  description
                                  liveStream
                                }
                                webRadios {
                                  id
                                  title
                                  description
                                  liveStream
                                }
                              }
                            }
                            """)
    }
}
