//
//  BrandRemoteOperations.swift
//  RadioPlus
//
//  Created by Derouiche Elyes on 20/12/2022.
//

import Foundation

struct BrandRemoteOperation: GraphQLOperationProtocol {
    typealias Input = BrandQuery
    typealias Output = BrandResponse
    
    var input: BrandQuery
    
    var operationString: String
    
    var method: HTTPMethods = .post
    
    var endURL: APIProvider = .api
    
    static func getAllBrands() -> Self {
        BrandRemoteOperation(input: .init(),
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
