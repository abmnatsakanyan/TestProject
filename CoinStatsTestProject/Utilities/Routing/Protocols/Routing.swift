//
//  Routing.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import Foundation

public protocol Routing {
    var key: RoutingAPI { get }
    var baseURL: URL { get }
    var method: HTTPMethod { get }
    var bodyParameters: EncodableParameter { get }
    var queryParameters: EncodableParameter { get }
    var headers: [String: String] { get }
    var acceptableStatusCode: Set<Int> { get }
    
    func request() throws -> URLRequest
}

extension Routing {
    
    var baseURL: URL {
        return Constants.BaseURL.dev
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var queryParameters: EncodableParameter {
        return QueryParameter(parameters: [:])
    }
    
    var bodyParameters: EncodableParameter {
        return BodyParameter()
    }
    
    var headers: [String: String] {
        return [:]
    }
    
    var acceptableStatusCode: Set<Int> {
        return [200]
    }
    
    func request() throws -> URLRequest {
        do {
            let url = baseURL.appendingPathComponent(key.path)
            var request = URLRequest(url: url)
            try bodyParameters.encode(request: &request)
            try queryParameters.encode(request: &request)
            return request
        }
    }
}
