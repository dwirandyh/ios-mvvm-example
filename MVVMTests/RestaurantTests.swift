//
//  RestaurantTests.swift
//  MVVMTests
//
//  Created by Dwi Randy Herdinanto on 02/03/21.
//

import XCTest
@testable import MVVM

class RestaurantTests: XCTestCase {

    var viewModel: RestaurantViewModel!
    var service: ServiceMock!

    override func setUpWithError() throws {
        self.service = ServiceMock()
        self.viewModel = RestaurantViewModel(service: self.service)
    }

    override func tearDownWithError() throws {
        self.service = nil
        self.viewModel = nil
        super.tearDown()
    }

    func testLoadRestaurantSuccess() throws {
        let restaurantDataExpected: RestaurantModel = RestaurantModel(id: "idTest", name: "nameTest", description: "descriptionTest", address: "addressTest", city: "cityTest", rating: 4)
        self.service.getRestaurantDetailStub = .success(restaurantDataExpected)

        // record data changed
        let restaurantResultExpectation = expectation(description: "Restaurant data is loaded")
        var restaurantResult: [RestaurantModel] = []
        self.viewModel.restaurant.observe(on: self) { (restaurantModel) in
            restaurantResult.append(restaurantModel)
            if restaurantResult.count == 2 {
                restaurantResultExpectation.fulfill()
            }
        }

        let isLoadingExpectation = expectation(description: "Loading state is changed")
        var isLoadingResult: [Bool] = []
        self.viewModel.isLoading.observe(on: self) { (isLoading) in
            isLoadingResult.append(isLoading)
            if isLoadingResult.count == 3 {
                isLoadingExpectation.fulfill()
            }
        }

        // run the unit
        self.viewModel.loadRestaurant()

        wait(for: [restaurantResultExpectation, isLoadingExpectation], timeout: 5)

        // State Verification
        XCTAssertEqual(restaurantResult, [
                        RestaurantModel(),
                        restaurantDataExpected]
        )
        XCTAssertEqual(isLoadingResult, [false, true, false])
        // Behavior Verification
        XCTAssertEqual(self.service.getRestaurantDetailWasCalled, 1)
    }

    func testLoadRestaurantEmpty() throws {
        self.service.getRestaurantDetailStub = .failure(ServiceError.empty)

        // Record state changed
        let isLoadingExpectation = expectation(description: "Loading state is changed")
        var isLoadingResult: [Bool] = []
        self.viewModel.isLoading.observe(on: self) { (isLoading) in
            isLoadingResult.append(isLoading)
            if isLoadingResult.count == 3 {
                isLoadingExpectation.fulfill()
            }
        }

        let errorExpectation = expectation(description: "Error state is changed")
        var errorMessageResult: String = ""
        self.viewModel.isError.observe(on: self) { (errorMessage) in
            errorMessageResult = errorMessage
            if !errorMessageResult.isEmpty {
                errorExpectation.fulfill()
            }
        }

        self.viewModel.loadRestaurant()

        wait(for: [errorExpectation, isLoadingExpectation], timeout: 5)

        // State verification
        XCTAssertEqual(isLoadingResult, [false, true, false])
        XCTAssertTrue(!errorMessageResult.isEmpty)

        // Behavior Verification
        XCTAssertEqual(self.service.getRestaurantDetailWasCalled, 1)
    }

    func testLoadRestaurantServerError() throws {
        self.service.getRestaurantDetailStub = .failure(ServiceError.serverError)

        // Record state changed
        let isLoadingExpectation = expectation(description: "Loading state is changed")
        var isLoadingResult: [Bool] = []
        self.viewModel.isLoading.observe(on: self) { (isLoading) in
            isLoadingResult.append(isLoading)
            if isLoadingResult.count == 3 {
                isLoadingExpectation.fulfill()
            }
        }

        let errorExpectation = expectation(description: "Error state is changed")
        var errorMessageResult: String = ""
        self.viewModel.isError.observe(on: self) { (errorMessage) in
            errorMessageResult = errorMessage
            if !errorMessageResult.isEmpty {
                errorExpectation.fulfill()
            }
        }

        self.viewModel.loadRestaurant()

        wait(for: [errorExpectation, isLoadingExpectation], timeout: 5)

        // State verification
        XCTAssertEqual(isLoadingResult, [false, true, false])
        XCTAssertTrue(!errorMessageResult.isEmpty)

        // Behavior Verification
        XCTAssertEqual(self.service.getRestaurantDetailWasCalled, 1)
    }

}

class ServiceMock: Service {
    var getRestaurantDetailStub: Result<RestaurantModel, Error>!
    var getRestaurantDetailWasCalled: Int = 0
    func getRestaurantDetail(onResult: @escaping (Result<RestaurantModel, Error>) -> Void) {
        onResult(self.getRestaurantDetailStub)
        self.getRestaurantDetailWasCalled += 1
    }
}
