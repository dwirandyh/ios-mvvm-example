//
//  AddReviewViewModel.swift
//  MVVM
//
//  Created by Dwi Randy Herdinanto on 17/02/21.
//

import Foundation

class AddReviewViewModel {

    var viewState: Dynamic<AddReviewState> = Dynamic(value: nil)
    var name: Dynamic<String> = Dynamic(value: "Dummy Name")
    var review: Dynamic<String> = Dynamic(value: "Dummy Review")
    var isAnonymous: Dynamic<Bool> = Dynamic(value: false)

    let service: Service

    init(service: Service = NetworkService()) {
        self.service = service
    }

    func submitReview() {
        let isValid = self.validate()

        if isValid {
            var reviewerName = name.value!
            if isAnonymous.value == true {
                reviewerName = "Anonymous"
            }

            self.service.postReview(name: reviewerName, review: review.value!, restaurantId: "rqdv5juczeskfw1e867") { (result) in
                switch result {
                case .success():
                    self.viewState.value = .success
                case .failure(let error):
                    guard let serviceError = error as? ServiceError else { return }
                    if serviceError == .clientError {
                        self.viewState.value = .clientError
                    } else if serviceError == .serverError {
                        self.viewState.value = .serverError
                    }
                }
            }
        } else {
            self.viewState.value = .invalidForm
        }
    }

    func validate() -> Bool {
        if name.value!.isEmpty || review.value!.isEmpty {
            return false
        }
        return true
    }
}
