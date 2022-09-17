//
//  ProcessingView.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import UIKit

final class ProcessingView: UIView, NIbIdentifiable {
    static var nibName: String? = "ProcessingView"
    static var identity: String? = "ProcessingView"
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    func animateIndicator() {
        activityIndicator.startAnimating()
    }
    
    func stopAnimatingIndicator() {
        activityIndicator.stopAnimating()
    }
}
