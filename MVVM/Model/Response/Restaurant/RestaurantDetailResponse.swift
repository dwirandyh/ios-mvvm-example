//
//  RestaurantDetailResponse.swift
//  MVVM
//
//  Created by Dwi Randy Herdinanto on 17/02/21.
//

import Foundation

struct RestaurantDetailResponse: Codable {
    var error: Bool
    var message: String
    var restaurant: RestaurantResponse
}
