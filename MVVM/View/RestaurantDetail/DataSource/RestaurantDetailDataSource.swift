//
//  RestaurantDetailDataSource.swift
//  MVVM
//
//  Created by Dwi Randy Herdinanto on 17/02/21.
//

import Foundation
import UIKit

class RestaurantDetailDataSource: NSObject, UITableViewDataSource {
    var viewModel: ViewModel!

    func registerTableView(viewModel: ViewModel, tableView: UITableView) {
        self.viewModel = viewModel

        tableView.register(UINib(nibName: "RestaurantDetailCell", bundle: nil), forCellReuseIdentifier: "RestaurantDetailCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantDetailCell", for: indexPath) as! RestaurantDetailCell
        cell.bind(restaurant: self.viewModel.restaurant)
        return cell
    }


}
