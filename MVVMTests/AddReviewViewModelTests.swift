//
//  AddReviewViewModelTests.swift
//  MVVMTests
//
//  Created by Dwi Randy Herdinanto on 23/03/21.
//

import XCTest
@testable import MVVM

class AddReviewViewModelTests: XCTestCase {

    var sut: AddReviewViewModel!
    var service: ServiceMock!

    override func setUpWithError() throws {
        self.service = ServiceMock()
        self.sut = AddReviewViewModel(service: service)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testValidationNameInValid() throws {
        // GIVEN
        self.sut.name.value = ""
        self.sut.review.value = "Review"

        // WHEN
        let result = sut.validate()

        // THEN
        XCTAssertFalse(result)
    }

    func testValidationReviewInValid() throws {
        // GIVEN
        self.sut.name.value = "Name"
        self.sut.review.value = ""

        // WHEN
        let result = sut.validate()

        // THEN
        XCTAssertFalse(result)
    }


    func testValidationValid() throws {
        // GIVEN
        self.sut.name.value = "Name"
        self.sut.review.value = "Randy"

        // WHEN
        let result = sut.validate()

        // THEN
        XCTAssertTrue(result)
    }


    func testSubmitReviewFormInValid() throws {
        // GIVEN
        self.sut.name.value = ""
        self.sut.review.value = "Review"

        self.sut.submitReview()


        XCTAssertEqual(self.sut.viewState.value!, AddReviewState.invalidForm)
    }

    func testSubmitReviewAnonym() throws {
        // GIVEN
        self.sut.name.value = "Randy"
        self.sut.review.value = "Review Test"
        self.sut.isAnonymous.value = true

        self.service.postReviewStub = Result.success(())

        // WHEN
        self.sut.submitReview()

        // THen
        let name = self.service.postReviewArgumentCaptor.0
        XCTAssertEqual(name, "Anonymous")
        XCTAssertEqual(self.service.postReviewCalled, 1)
    }

    func testSubmitReviewSuccess() throws {
        // GIVEN
        self.sut.name.value = "Randy Test"
        self.sut.review.value = "Review Test"

        self.service.postReviewStub = Result.success(())

        // When
        self.sut.submitReview()

        // Then
        XCTAssertEqual(self.sut.viewState.value!, AddReviewState.success)
        XCTAssertEqual(self.service.postReviewCalled, 1)
    }

    func testSubmitReviewClientError() throws {
        // GIVEN
        self.sut.name.value = "Randy Test"
        self.sut.review.value = "Review Test"

        self.service.postReviewStub = Result.failure(ServiceError.clientError)

        // When
        self.sut.submitReview()

        // Then
        XCTAssertEqual(self.sut.viewState.value!, AddReviewState.clientError)
        XCTAssertEqual(self.service.postReviewCalled, 1)
    }

    func testSubmitReviewServerError() throws {
        // GIVEN
        self.sut.name.value = "Randy Test"
        self.sut.review.value = "Review Test"

        self.service.postReviewStub = Result.failure(ServiceError.serverError)

        // When
        self.sut.submitReview()

        // Then
        XCTAssertEqual(self.sut.viewState.value!, AddReviewState.serverError)
        XCTAssertEqual(self.service.postReviewCalled, 1)
    }
}
