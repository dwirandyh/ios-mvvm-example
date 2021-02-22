//
//  AddReviewViewController.swift
//  MVVM
//
//  Created by Dwi Randy Herdinanto on 17/02/21.
//

import UIKit

class AddReviewViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var senderLabel: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var reviewTextField: UITextField!
    @IBOutlet weak var senderSwitch: UISwitch!

    var viewModel: AddReviewViewModel = AddReviewViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupObserver()
    }

    func setupObserver() {
        self.nameTextField.bind(with: self.viewModel.name)

        self.reviewTextField.bind(with: self.viewModel.review)

        self.senderSwitch.bind(with: self.viewModel.isAnonymous)

        self.viewModel.name.observe(on: self.nameTextField){ (value) in
            self.nameLabel.text = value
        }
        self.viewModel.review.observe(on: self.reviewTextField){ (value) in
            self.reviewLabel.text = "\(value)"
        }

        self.viewModel.isAnonymous.observe(on: self.senderLabel) { (isAnonymous) in
            self.senderLabel.text = isAnonymous ? "Anonymous" : "Real Name"
        }
    }

    @IBAction func submitData(_ sender: Any) {

        self.viewModel.submitReview()
    }

    deinit {
        
    }
}
