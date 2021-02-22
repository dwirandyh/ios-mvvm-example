//
//  ViewModel.swift
//  MVVM
//
//  Created by Dwi Randy Herdinanto on 16/02/21.
//

import Foundation

class ViewModel: NSObject {

    var service: Service

    var restaurant: Dynamic<RestaurantModel> = Dynamic<RestaurantModel>(value: RestaurantModel())
    var isLoading: Dynamic<Bool> = Dynamic<Bool>(value: false)
    
    override init() {
        self.service = Service()
        super.init()
    }

    func loadRestaurant() {
        self.isLoading.value = true
        self.service.getRestaurantDetail { (restaurantModel) in
            DispatchQueue.main.sync {
                self.restaurant.value = restaurantModel
                self.isLoading.value = false
            }
        }
    }

}
