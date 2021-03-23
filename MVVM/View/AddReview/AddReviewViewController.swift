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

        self.viewModel.name.observe(on: self){ (value) in
            self.nameLabel.text = value
        }
        self.viewModel.review.observe(on: self){ (value) in
            self.reviewLabel.text = "\(value)"
        }

        self.viewModel.isAnonymous.observe(on: self) { (isAnonymous) in
            self.senderLabel.text = isAnonymous ? "Anonymous" : "Real Name"
        }

        self.viewModel.viewState.observe(on: self) { (review) in
            switch review {
            case .invalidForm:
                let alert = UIAlertController(title: "Invalid Form", message: "Form tidak boleh kosong", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            case .serverError:
                let alert = UIAlertController(title: "Error Message", message: "Server Error", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            case .clientError:
                let alert = UIAlertController(title: "Error Message", message: "Client Error", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            case .success:
                let alert = UIAlertController(title: "Success", message: "Review berhasil terkirim", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

    @IBAction func submitData(_ sender: Any) {
        self.viewModel.submitReview()
    }

    deinit {
        self.viewModel.name.remove(observer: self)
        self.viewModel.review.remove(observer: self)
        self.viewModel.isAnonymous.remove(observer: self)
        self.viewModel.viewState.remove(observer: self)
    }
}
