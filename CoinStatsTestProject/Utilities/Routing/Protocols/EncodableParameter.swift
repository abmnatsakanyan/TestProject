//
//  EncodableParameter.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import Foundation

public protocol EncodableParameter {
    var parameters: [String: Any] { get }
    
    func encode(request: inout URLRequest) throws
}
