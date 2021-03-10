//
//  ViewController.swift
//  MVVM
//
//  Created by Dwi Randy Herdinanto on 16/02/21.
//

import UIKit

class RestaurantDetailViewController: UIViewController {

    var viewModel: RestaurantViewModel = RestaurantViewModel(service: NetworkService())
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

        self.viewModel.isError.observe(on: self) { (message) in
            self.showMessage(message: message)
        }
    }

    func showMessage(message: String) {
        let alert = UIAlertController(title: "Error Message", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    deinit {
        self.viewModel.isLoading.remove(observer: self)
        self.viewModel.isError.remove(observer: self)
    }
}
