//
//  BaseViewModel.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import UIKit
import RxRelay
import RxSwift

class BaseViewModel<Input>: ViewModeling {
    var input: Input
    var disposeBag: DisposeBag = DisposeBag()
    var error: PublishRelay<Error?> = PublishRelay<Error?>()
    var isProcessing: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)

    init(input: Input) {
        self.input = input
    }
}
