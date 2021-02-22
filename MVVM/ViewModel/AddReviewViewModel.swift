//
//  AddReviewViewModel.swift
//  MVVM
//
//  Created by Dwi Randy Herdinanto on 17/02/21.
//

import Foundation

class AddReviewViewModel {
    var name: Dynamic<String> = Dynamic(value: "Dummy Name")
    var review: Dynamic<String> = Dynamic(value: "Dummy Review")
    var isAnonymous: Dynamic<Bool> = Dynamic(value: false)

    func submitReview() {
        print(self.name.value)
        print(self.review.value)
    }
}
