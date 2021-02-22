//
//  RestaurantDetailCell.swift
//  MVVM
//
//  Created by Dwi Randy Herdinanto on 17/02/21.
//

import UIKit

class RestaurantDetailCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!

    func bind(restaurant: Dynamic<RestaurantModel>) {
        restaurant.observe(on: self) { restaurant in
            self.titleLabel.text = restaurant.name
            self.descriptionLabel.text = restaurant.description
            self.addressLabel.text = "\(restaurant.address), \(restaurant.city)"
        }
    }
    
}
