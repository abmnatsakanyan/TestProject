//
//  BaseViewController.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewController<T: ViewModeling>: UIViewController {
    typealias ViewModel = T
    var viewModel: ViewModel!
    
    var processingView: ProcessingView = ProcessingView.loadFromNib(in: .main)!
    
    var disposeBag: DisposeBag = DisposeBag()
    
    var backgroundColor: UIColor = .csWhite {
        didSet {
            view.backgroundColor = backgroundColor
        }
    }
    
    var respectViewsLayoutMargin: Bool = false {
        didSet {
            viewRespectsSystemMinimumLayoutMargins = respectViewsLayoutMargin
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        respectViewsLayoutMargin = false
        view.backgroundColor = backgroundColor
        subscribeViewModel()
        self.setupIndicatorView()
    }
    
    func subscribeViewModel() {
        self.subscribeToProcessing()
        self.subscribeToError()
    }

    private func setupIndicatorView() {
        processingView.translatesAutoresizingMaskIntoConstraints = false
        processingView.isHidden = true
        view.addSubview(processingView)
        processingView.translatesAutoresizingMaskIntoConstraints = false
        processingView.addConstraint(sides: .all, edges: .zero, activate: true)
    }

    private func subscribeToProcessing() {
        viewModel.isProcessing.observe(on: MainScheduler.instance)
            .map { (parent: self.view, state: $0) }
            .bind(to: processingView.rx.loader)
            .disposed(by: disposeBag)
    }
    
    private func subscribeToError() {
        viewModel.error.observe(on: MainScheduler.instance)
            .map { MessageModel(title: "Error", description: $0?.localizedDescription ?? "Unknown") }
            .bind(onNext: { [weak self] messageModel in
                self?.showAlert(title: messageModel.title, message: messageModel.description)
            })
        .disposed(by: disposeBag)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}
