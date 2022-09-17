//
//  Setupable.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import Foundation

protocol Setupable {
    associatedtype Model
    
    func setup(with model: Model)
}
