//
//  UIBinding.swift
//  MVVM
//
//  Created by Dwi Randy Herdinanto on 18/02/21.
//

import Foundation
import UIKit

protocol Bindable {
    associatedtype BindingType: Equatable
    func bind(with observable: Dynamic<BindingType>)
}

extension UITextField: Bindable, UITextFieldDelegate {
    typealias BindingType = String

    private struct BinderHolder {
        static var _binder: Dynamic<BindingType>?
    }

    private var binder: Dynamic<BindingType>? {
        get {
            guard let binderHolder = objc_getAssociatedObject(self, &BinderHolder._binder) as? Dynamic<BindingType> else {
                return nil
            }
            return binderHolder
        }
        set(newValue) {
            objc_setAssociatedObject(self, &BinderHolder._binder, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    func bind(with observable: Dynamic<BindingType>) {
        self.delegate = self
        binder = observable
        observable.observe(on: self) { newText in
            if self.text != newText {
                self.text = newText
            }
        }
    }

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
        binder?.value = updatedString ?? ""
        return true
    }
}

extension UISwitch: Bindable {
    typealias BindingType = Bool

    private struct BinderHolder {
        static var _binder: Dynamic<BindingType>?
    }

    private var binder: Dynamic<BindingType>? {
        get {
            guard let binderHolder = objc_getAssociatedObject(self, &BinderHolder._binder) as? Dynamic<BindingType> else {
                return nil
            }
            return binderHolder
        }
        set(newValue) {
            objc_setAssociatedObject(self, &BinderHolder._binder, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    open override func awakeFromNib() {
        super.awakeFromNib()
        self.addTarget(self, action: #selector(self.switchChanged(sender:)), for: UIControl.Event.valueChanged)
    }

    func bind(with observable: Dynamic<BindingType>) {
        binder = observable
        observable.observe(on: self) { newState in
            self.isOn = newState
        }
    }

    @objc func switchChanged(sender: UISwitch) {
        binder?.value = sender.isOn
    }
}
