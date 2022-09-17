//
//  BodyParameter.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import Foundation

final class BodyParameter: EncodableParameter {
    var parameters: [String: Any] = [:]

    func encode(request: inout URLRequest) throws {
        guard !parameters.isEmpty else { return }
        
        guard JSONSerialization.isValidJSONObject(parameters) else {
            throw NetworkError.attempToEncodePrarmeters(parameters)
        }
        
        let data = try JSONSerialization.data(withJSONObject: [parameters], options: .prettyPrinted)
        request.httpBody = data
    }
}
