//
//  OptionSetIterator.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import UIKit

typealias OptionSetSequence = OptionSet & Sequence

struct OptionSetIterator<Element: OptionSet>: IteratorProtocol where Element.RawValue: FixedWidthInteger {

    private let element: Element
    private lazy var remindingBites = self.element.rawValue
    private var bitMask: Self.Element.RawValue = 1

    init(element: Element) {
        self.element = element
    }

    public mutating func next() -> Element? {
        while remindingBites != 0 {
            defer { bitMask = bitMask &* 2 }
            if remindingBites & bitMask != 0 {
                remindingBites = remindingBites & ~bitMask
                return Element(rawValue: bitMask)
            }
        }
        return nil
    }
}
