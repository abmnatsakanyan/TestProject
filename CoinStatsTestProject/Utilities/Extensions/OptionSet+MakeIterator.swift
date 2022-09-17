//
//  OptionSet+MakeIterator.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import UIKit

extension OptionSet where Self.RawValue: FixedWidthInteger {
    func makeIterator() -> OptionSetIterator<Self> {
        return OptionSetIterator(element: self)
    }
}
