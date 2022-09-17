//
//  ViewModeling.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import UIKit
import RxSwift
import RxRelay

protocol ViewModeling {
    var error: PublishRelay<Error?> { get set }
    var isProcessing: BehaviorRelay<Bool> { get set }
}
