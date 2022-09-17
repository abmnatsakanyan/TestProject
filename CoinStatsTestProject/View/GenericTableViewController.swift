//
//  GenericTableViewController.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import UIKit

typealias SetupableTableViewCell = UITableViewCell & Setupable & NIbIdentifiable
typealias SetupableTableViewHeaderFooter = UITableViewHeaderFooterView & Setupable & NIbIdentifiable

class GenericTableViewController<T: DataSource, CellView: SetupableTableViewCell, HeaderView: SetupableTableViewHeaderFooter, FooterView: SetupableTableViewHeaderFooter>: BaseViewController<T>, UITableViewDataSource, UITableViewDelegate where CellView.Model == T.Section.CellModel, HeaderView.Model == T.Section.HeaderModel, FooterView.Model == T.Section.FooterModel {
    
    lazy var tableView: UITableView = createTableView()
    lazy var tableViewBackgroundColor: UIColor? = tableView.backgroundColor {
        didSet {
            tableView.backgroundColor = tableViewBackgroundColor
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells(in: tableView)
        bindDataSource()
    }
    
    func createTableView() -> UITableView {
        let tableView = UITableView()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.addConstraint(sides: .all, constraint: .equal(constant: 0), activate: true)
        
        registerCells(in: tableView)
        
        return tableView
    }
    
    func registerCells(in tableView: UITableView) {
        tableView.registerHeaderFooter(identityObject: HeaderView.self)
        tableView.registerHeaderFooter(identityObject: FooterView.self)
        tableView.registerCell(identityObject: CellView.self)
    }
    
    func bindDataSource() {
        viewModel.dataSource.subscribe(onNext: { _ in
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.dataSource.value.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.value[section].cellModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: CellView.self) ?? UITableViewCell()
        
        if let cellView = cell as? CellView, let cellModel = viewModel.cellModel(for: indexPath) {
            cellView.setup(with: cellModel)
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerModel = viewModel.headerModel(for: section) else { return nil }

        let headerView = tableView.dequeueReusableHeaderFooterView(with: HeaderView.self) as? HeaderView
        
        headerView?.setup(with: headerModel)

        return headerView
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footerModel = viewModel.footerModel(for: section), !footerModel.isEmpty else { return nil }
        
        let footerView = tableView.dequeueReusableHeaderFooterView(with: FooterView.self) as? FooterView

        footerView?.setup(with: footerModel)

        return footerView
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard let footerModel = viewModel.footerModel(for: section), !footerModel.isEmpty else { return 0 }
        
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) { }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) { }
}
