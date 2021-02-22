//
//  Service.swift
//  MVVM
//
//  Created by Dwi Randy Herdinanto on 16/02/21.
//

import Foundation

class Service {
    func getRestaurantDetail(onSuccess: @escaping (_ restaurant: RestaurantModel) -> Void ) {
        let components = URLComponents(string: "https://restaurant-api.dicoding.dev/detail/rqdv5juczeskfw1e867")
        let request = URLRequest(url: components!.url!)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else { return }
            if let data = data {
                if response.statusCode == 200 {
                    let decoder = JSONDecoder()
                    let restaurantDetailResponse = try! decoder.decode(RestaurantDetailResponse.self, from: data)
                    let restaurantModel = restaurantDetailResponse.restaurant.mapToModel()
                    onSuccess(restaurantModel)
                } else {
                    return
                }
            }
        }

        task.resume()
    }
}
