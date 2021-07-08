//
//  Observable.swift
//  ProjectManager
//
//  Created by 강경 on 2021/07/09.
//

import Foundation

class Observable<T> {
    private var listener: ((T?) -> Void)?
    
    var value: T? {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T?) {
        self.value = value
    }
    
    func bind(_ listener: @escaping (T?) -> Void) {
        listener(value)
        self.listener = listener
    }
}
