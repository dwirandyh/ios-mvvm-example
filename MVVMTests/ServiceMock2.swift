//
//  ServiceMock2.swift
//  MVVMTests
//
//  Created by Dwi Randy Herdinanto on 23/03/21.
//

import Foundation
@testable import MVVM

class ServiceMock2: Service {

    func getRestaurantDetail(onResult: @escaping (Result<RestaurantModel, Error>) -> Void) {

    }

    var postReviewStub: Result<Void, Error>!
    var postReviewArgumentCaptor: (name: String, review: String)!
    var postReviewCalled: Int = 0

    func postReview(name: String, review: String, restaurantId: String, onResult: @escaping ((Result<Void, Error>) -> Void)) {
        self.postReviewCalled += 1
        self.postReviewArgumentCaptor = (name, review)

        onResult(self.postReviewStub)
    }

    
}
