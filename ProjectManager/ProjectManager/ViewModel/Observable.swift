//
//  Observable.swift
//  ProjectManager
//
//  Created by 수꿍, 휴 on 2022/09/15.
//

final class Observable<T> {
    var value: T {
        didSet {
            self.listener?(value)
        }
    }

    var listener: ((T) -> Void)?

    init(_ value: T) {
        self.value = value
    }

    func subscribe(listener: @escaping (T) -> Void) {
        listener(value)
        self.listener = listener
    }
    
    func unsubscribe() {
        self.listener = nil
    }
}
