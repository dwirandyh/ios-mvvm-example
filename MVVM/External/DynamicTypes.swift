//
//  DynamicTypes.swift
//  MVVM
//
//  Created by Dwi Randy Herdinanto on 17/02/21.
//

import Foundation
import UIKit


class Dynamic<T> {

    typealias ObserverClosure = (T) -> ()

    struct Observer<ObservedType> {
        weak var observer: AnyObject?
        let completion: (ObservedType) -> Void
    }

    private var observers: [Observer<T>]

    public var value: T? {
        didSet {
            if let _ = value {
                notifyObservers()
            }
        }
    }

    public init(value: T? = nil) {
        self.value = value
        observers = []
    }

    public func observe(on observer: AnyObject, observerBlock: @escaping (T) -> Void) {
        observers.append(Observer(observer: observer, completion: observerBlock))
        if let value = value {
            observerBlock(value)
        }
    }

    public func remove(observer: AnyObject) {
        observers = observers.filter { $0.observer !== observer }
    }

    private func notifyObservers() {
        for observer in observers {
            if let value = value {
                DispatchQueue.main.async { observer.completion(value) }
            }
        }
    }

}
