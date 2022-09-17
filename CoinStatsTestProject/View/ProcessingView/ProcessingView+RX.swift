//
//  ProcessingView+RX.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import RxSwift
import UIKit

extension Reactive where Base: ProcessingView {
    var loader: Binder<(parent: UIView, state: Bool)> {
        return Binder(self.base) { loader, result in
            result.parent.bringSubviewToFront(loader)
            loader.isHidden = !result.state
            if result.state {
                loader.animateIndicator()
            } else {
                loader.stopAnimatingIndicator()
            }
        }
    }
}
