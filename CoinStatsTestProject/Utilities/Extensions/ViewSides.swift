//
//  ViewSides.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import UIKit

struct ViewSides: OptionSet, Hashable, Sequence {
    
    var rawValue: Int
    
    static let top: ViewSides = .init(rawValue: 1 << 0)
    static let leading: ViewSides = .init(rawValue: 1 << 1)
    static let trailing: ViewSides = .init(rawValue: 1 << 2)
    static let bottom: ViewSides = .init(rawValue: 1 << 3)
    static let centerX: ViewSides = .init(rawValue: 1 << 4)
    static let centerY: ViewSides = .init(rawValue: 1 << 5)
    static let height: ViewSides = .init(rawValue: 1 << 6)
    static let width: ViewSides = .init(rawValue: 1 << 7)
    static let all: ViewSides = [[.top, .bottom], [.leading, .trailing]]
}

extension ViewSides {
    var isCapable: Bool {
        guard !self.contains(.all) else { return true }
        
        return self.isDisjoint(with: [.top, .leading]) ||
        self.isDisjoint(with: [.top, .trailing]) ||
        self.isDisjoint(with: [.bottom, .trailing]) ||
        self.isDisjoint(with: [.bottom, .leading]) ||
        self.isDisjoint(with: [.height, .all])
    }
    
    var isAnchorX: Bool {
        return self.isDisjoint(with: [.width, .height, .centerY, .bottom, .top])
    }
    
    var isAnchorY: Bool {
        return self.isDisjoint(with: [.leading, .trailing, .width, .height, .centerX])
    }
    
    var isDimension: Bool {
        self.isDisjoint(with: [.leading, .trailing, .width, .height, .centerY, .centerX, .top, .bottom])
    }
    
    func acnhorX(guid: UILayoutGuide) -> NSLayoutAnchor<NSLayoutXAxisAnchor>? {
        switch self {
        case .trailing:
            return guid.trailingAnchor
        case .leading:
            return guid.leadingAnchor
        case .centerX:
            return guid.centerXAnchor
        default:
            return nil
        }
    }
    
    func acnhorY(guid: UILayoutGuide) -> NSLayoutAnchor<NSLayoutYAxisAnchor>? {
        switch self {
        case .top:
            return guid.topAnchor
        case .bottom:
            return guid.bottomAnchor
        case .centerY:
            return guid.centerYAnchor
        default:
            return nil
        }
    }
    
    func dimension(guid: UILayoutGuide) -> NSLayoutDimension? {
        switch self {
        case .height:
            return guid.heightAnchor
        case .width:
            return guid.widthAnchor
        default:
            return nil
        }
    }
    
    func equivalentValue(insent: UIEdgeInsets) -> CGFloat {
        switch self {
        case .leading:
            return insent.left
        case .trailing:
            return insent.right
        case .top:
            return insent.top
        case .bottom:
            return insent.bottom
        default:
            return 0
        }
    }
}
