//
//  RestaurantResponse.swift
//  MVVM
//
//  Created by Dwi Randy Herdinanto on 17/02/21.
//

import Foundation

struct RestaurantResponse: Codable {
    var id: String
    var name: String
    var description: String
    var address: String
    var city: String
    var rating: Float
}

extension RestaurantResponse {
    func mapToModel() -> RestaurantModel {
        return RestaurantModel(id: self.id, name: self.name, description: self.description, address: self.address, city: self.city, rating: self.rating)
    }
}
