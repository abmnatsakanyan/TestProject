//
//  QueryParameter.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import Foundation

final class QueryParameter: EncodableParameter {
    var parameters: [String: Any]
    
    init(parameters: [String: Any]) {
        self.parameters = parameters
    }
    
    func encode(request: inout URLRequest) {
        guard let url = request.url, !parameters.isEmpty else { return }

        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let existingQueryItem = components?.queryItems ?? []

        components?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") } + existingQueryItem

        request.url = components?.url
    }
}
