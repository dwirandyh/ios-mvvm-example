//
//  ServiceMock.swift
//  MVVMTests
//
//  Created by Dwi Randy Herdinanto on 16/03/21.
//

import Foundation
@testable import MVVM


class ServiceMock: Service {

    var getRestaurantDetailStub: Result<RestaurantModel, Error>!
    var getRestaurantDetailWasCalled: Int = 0
    func getRestaurantDetail(onResult: @escaping (Result<RestaurantModel, Error>) -> Void) {
        onResult(self.getRestaurantDetailStub)
        self.getRestaurantDetailWasCalled += 1
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
