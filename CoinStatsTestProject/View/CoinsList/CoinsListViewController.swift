//
//  CoinsListViewController.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import UIKit

final class CoinsListViewController: GenericTableViewController<CoinsListViewModel, CoinsListTableViewCell, CoinsListHeaderView, EmptyHeaderAndFooterView> {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        viewModel.fetchCoins()
        
        configNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.broadCastUpdates()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        viewModel.stopBroadCastTimer()
    }
    
    private func configNavBar() {
        let usdBarItem = UIBarButtonItem(title: viewModel.usdBarItemTitle, style: .plain, target: self, action: #selector(didTappedNavBar))
        usdBarItem.tintColor = UIColor.csGray
        
        let searchBarItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTappedNavBar))
        searchBarItem.tintColor = UIColor.csGray
        
        navigationItem.rightBarButtonItems = [searchBarItem, usdBarItem]
    }
    
    @objc private func didTappedNavBar() { }

    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate {
            loadMoreIfNeeded(scrollView)
        }
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        loadMoreIfNeeded(scrollView)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cellModel = viewModel.cellModel(for: indexPath) else { return }
        let coinDetail = ViewControllerPorivder.coinDetails(coinCell: cellModel)
        navigationController?.pushViewController(coinDetail.module!, animated: true)
    }
    
    private func loadMoreIfNeeded(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.size.height {
//            viewModel.fetchCoins() // We can use this for paging
        }
    }
}
