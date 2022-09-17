//
//  CoinDetailsViewController.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 17.09.22.
//

import UIKit

final class CoinDetailsViewController: BaseViewController<CoinDetailViewModel> {
    
    var myLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = .csGray
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.title
        myLabel.text = viewModel.name
        viewModel.fetchCoinDetails()
        
        view.addSubview(myLabel)
        myLabel.addConstraint(sides: [.centerY, .leading, .trailing], constraint: .equal(constant: 0), activate: true)
    }
}

