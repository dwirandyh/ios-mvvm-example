//
//  Service.swift
//  MVVM
//
//  Created by Dwi Randy Herdinanto on 16/02/21.
//

import Foundation

enum ServiceError: Error {
    case empty
    case clientError
    case serverError
}


protocol Service {
    func getRestaurantDetail(onResult: @escaping (_ restaurant: Result<RestaurantModel, Error>) -> Void )
}

class NetworkService: Service {
    func getRestaurantDetail(onResult: @escaping (_ restaurant: Result<RestaurantModel, Error>) -> Void ) {
        let components = URLComponents(string: "https://restaurant-api.dicoding.dev/detail/rqdv5juczeskfw1e867")
        let request = URLRequest(url: components!.url!)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else {
                onResult(.failure(ServiceError.clientError))
                return
            }

            if error != nil {
                onResult(.failure(ServiceError.serverError))
            }

            if let data = data {
                if response.statusCode == 200 {
                    let decoder = JSONDecoder()
                    let restaurantDetailResponse = try! decoder.decode(RestaurantDetailResponse.self, from: data)
                    let restaurantModel = restaurantDetailResponse.restaurant.mapToModel()
                    onResult(.success(restaurantModel))
                } else {
                    onResult(.failure(ServiceError.clientError))
                }
            }
        }

        task.resume()
    }

    func submitReview(name: String, review: String, isAnonym: Bool, onResult: @escaping ( (_ result: Result<Void, Error>) -> Void)) {
        // send review data
        onResult(Result.success(()))
    }

}
