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
    
    static func getGrid(with startDate: Date, endDate: Date, station: Stations) -> Self {
        GridRemoteOperations(input:
                .init(start: startDate.posixTime(), end: endDate.posixTime(), station: station),
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
    
    public func buildURLRequest() throws -> URLRequest {
        guard let url = URL(string: self.endURL.rawValue) else { throw NetworkProviderError.urlBuilder }
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue(token, forHTTPHeaderField: "X-Token")
        urlRequest.setValue("application/json", forHTTPHeaderField:"Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField:"Accept")
        urlRequest.setValue("gzip, deflate, br", forHTTPHeaderField:"Accept-Encoding")
        
        urlRequest.httpBody = try JSONEncoder().encode(self)
        
        return urlRequest
    }
}
