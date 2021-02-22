//
//  ViewController.swift
//  MVVM
//
//  Created by Dwi Randy Herdinanto on 16/02/21.
//

import UIKit

class RestaurantDetailViewController: UIViewController {

    var viewModel: ViewModel = ViewModel()
    var dataSource: RestaurantDetailDataSource = RestaurantDetailDataSource()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingIndicatorView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self.dataSource
        self.dataSource.registerTableView(viewModel: self.viewModel, tableView: self.tableView)

        self.setupObserver()

        self.viewModel.loadRestaurant()
    }

    func setupObserver() {
        self.viewModel.isLoading.observe(on: self) { [weak self] (isLoading) in
            guard let self = self else { return }
            self.loadingIndicatorView.isHidden = !isLoading
            self.tableView.isHidden = isLoading
        }
    }

    deinit {
        self.viewModel.isLoading.remove(observer: self)
    }
}
