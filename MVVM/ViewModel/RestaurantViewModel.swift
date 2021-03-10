//
//  ViewModel.swift
//  MVVM
//
//  Created by Dwi Randy Herdinanto on 16/02/21.
//

import Foundation

class RestaurantViewModel {

    var service: Service

    var restaurant: Dynamic<RestaurantModel> = Dynamic<RestaurantModel>(value: RestaurantModel())
    var isLoading: Dynamic<Bool> = Dynamic<Bool>(value: false)
    var isError: Dynamic<String> = Dynamic<String>(value: nil)

    init(service: Service) {
        self.service = service
    }

    func loadRestaurant() {
        self.isLoading.value = true
        self.service.getRestaurantDetail { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.restaurant.value = data
                case .failure(let error):
                    guard let error = error as? ServiceError else { return }
                    switch error {
                    case .empty:
                        self.isError.value = "Data is Empty"
                    case .clientError:
                        self.isError.value = "Failed to extract Data"
                    case .serverError:
                        self.isError.value = "Failed to Connect to Server"
                    }
                }
                self.isLoading.value = false
            }
        }
    }

}
