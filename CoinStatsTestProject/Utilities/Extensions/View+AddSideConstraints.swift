//
//  View+AddSideConstraints.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import UIKit

extension UIView {

    typealias ViewConstraint = (view: UIView, side: ViewSides)
    
    enum ConstraintMode {
        case equal(constant: CGFloat)
        case greatherOrEqual(then: CGFloat)
        case lessOrEqual(then: CGFloat)
        
        func constraint<T: AnyObject>(left: NSLayoutAnchor<T>, right: NSLayoutAnchor<T>) -> NSLayoutConstraint {
            switch self {
            case .equal(let constant):
                return left.constraint(equalTo: right, constant: constant)
            case .greatherOrEqual(let constant):
                return left.constraint(greaterThanOrEqualTo: right, constant: constant)
            case .lessOrEqual(let constant):
                return left.constraint(lessThanOrEqualTo: right, constant: constant)
            }
        }

        func dimension(layout: NSLayoutDimension) -> NSLayoutConstraint {
            switch self {
            case .equal(let constant):
                return layout.constraint(equalToConstant: constant)
            case .greatherOrEqual(let then):
                return layout.constraint(greaterThanOrEqualToConstant: then)
            case .lessOrEqual(let then):
                return layout.constraint(lessThanOrEqualToConstant: then)
            }
        }
    }

    @discardableResult
    func addConstraint(parent: UIView? = nil, sides: ViewSides, constraint: ConstraintMode, respectSafeArea: Bool = false, activate: Bool = false) -> [ViewSides: NSLayoutConstraint] {
        var constraints: [ViewSides: NSLayoutConstraint] = [:]
        guard let parent = parent ?? self.superview else {
            return constraints
        }
        self.directionalLayoutMargins = .zero
        parent.directionalLayoutMargins = .zero
        self.insetsLayoutMarginsFromSafeArea = false
        parent.insetsLayoutMarginsFromSafeArea = false
        let parentMargins = respectSafeArea ? parent.safeAreaLayoutGuide : parent.layoutMarginsGuide
        let currentMargins = self.layoutMarginsGuide
        for side in sides {
            if let leftAnchorX = side.acnhorX(guid: currentMargins), let rightAnchorX = side.acnhorX(guid: parentMargins) {
                let constantX: NSLayoutConstraint
                if side == .trailing {
                    constantX = constraint.constraint(left: rightAnchorX, right: leftAnchorX)
                } else {
                    constantX = constraint.constraint(left: leftAnchorX, right: rightAnchorX)
                }
                constraints[side] = constantX
                constantX.isActive = activate

            }
            if let leftAnchorY = side.acnhorY(guid: currentMargins), let rightAnchorY = side.acnhorY(guid: parentMargins) {
                let constantY: NSLayoutConstraint
                if side == .top {
                    constantY = constraint.constraint(left: leftAnchorY, right: rightAnchorY)
                } else {
                    constantY = constraint.constraint(left: rightAnchorY, right: leftAnchorY)
                }
                constraints[side] = constantY
                constantY.isActive = activate

            }
            if let leftDimension = side.dimension(guid: currentMargins) {
                let constantX = constraint.dimension(layout: leftDimension)
                constraints[[side]] = constantX
                constantX.isActive = activate

            }
        }

        return constraints
    }

    @discardableResult
    func addConstraint(sides: ViewSides, constraint: ConstraintMode, to view: ViewConstraint, respectSafeArea: Bool = false, directionalLayout: NSDirectionalEdgeInsets = .zero, respectInsetsLayout: Bool = false, activate: Bool = false) -> [ViewSides: NSLayoutConstraint] {

        var constraints: [ViewSides: NSLayoutConstraint] = [:]
        guard sides.isCapable else {
            assertionFailure("Sides are not capable with each other.")
            return [:]
        }
        var iterableOtherSides = view.side.makeIterator()

        for side in sides {
            guard let nextElement = iterableOtherSides.next() else { return [:] }
            let leftLayout = self.layoutMarginsGuide
            let rightLayout = respectSafeArea ? view.view.safeAreaLayoutGuide : view.view.layoutMarginsGuide
            self.directionalLayoutMargins = directionalLayout
            view.view.directionalLayoutMargins = directionalLayout
            self.insetsLayoutMarginsFromSafeArea = respectInsetsLayout
            view.view.insetsLayoutMarginsFromSafeArea = respectInsetsLayout

            if let leftAnchorX = side.acnhorX(guid: leftLayout), let rightAnchorX = nextElement.acnhorX(guid: rightLayout) {
                let constantX = constraint.constraint(left: leftAnchorX, right: rightAnchorX)
                constraints[[side, nextElement]] = constantX
                constantX.isActive = activate
            }

            if let leftAnchorY = side.acnhorY(guid: leftLayout), let rightAnchorY = nextElement.acnhorY(guid: rightLayout) {
                let constantY: NSLayoutConstraint
                if side == .top && view.side == .bottom {
                    constantY = constraint.constraint(left: rightAnchorY, right: leftAnchorY)
                } else {
                    constantY = constraint.constraint(left: leftAnchorY, right: rightAnchorY)
                }
                constraints[[side, nextElement]] = constantY
                constantY.isActive = activate
            }
            if let leftDimension = side.dimension(guid: leftLayout) {
                let constantX = constraint.dimension(layout: leftDimension)
                constraints[[side]] = constantX
                constantX.isActive = activate
            }
        }
        return constraints
    }

    @discardableResult
    func addConstraint(parent: UIView? = nil, sides: ViewSides, edges: UIEdgeInsets, respectSafeArea: Bool = false, activate: Bool = false) -> [ViewSides: NSLayoutConstraint] {

        var constraints: [ViewSides: NSLayoutConstraint] = [:]
        guard let parent = parent ?? self.superview else {
            return constraints
        }
        guard sides.isCapable else {
            assertionFailure("Sides are not capable with each other.")
            return [:]
        }
        self.directionalLayoutMargins = .zero
        parent.directionalLayoutMargins = .zero
        let parentMargins = respectSafeArea ? parent.safeAreaLayoutGuide : parent.layoutMarginsGuide
        let currentMargins = self.layoutMarginsGuide
        self.insetsLayoutMarginsFromSafeArea = false
        parent.insetsLayoutMarginsFromSafeArea = false

        for side in sides {
            if let leftAnchorX = side.acnhorX(guid: currentMargins), let rightAnchorX = side.acnhorX(guid: parentMargins) {
                let constantX = ConstraintMode.equal(constant: side.equivalentValue(insent: edges)).constraint(left: leftAnchorX, right: rightAnchorX)
                constraints[side] = constantX
                constantX.isActive = activate
            }
            if let leftAnchorY = side.acnhorY(guid: currentMargins), let rightAnchorY = side.acnhorY(guid: parentMargins) {
                let constantY = ConstraintMode.equal(constant: side.equivalentValue(insent: edges)).constraint(left: leftAnchorY, right: rightAnchorY)
                constraints[side] = constantY
                constantY.isActive = activate
            }
        }
        return constraints
    }
}

extension Dictionary where Key == ViewSides, Value == NSLayoutConstraint {

    func activateConstraints() {
        values.forEach { constraint in
            constraint.isActive = true
        }
    }

    func deactivateConstraints() {
        values.forEach { constraint in
            constraint.isActive = false
        }
    }
}
