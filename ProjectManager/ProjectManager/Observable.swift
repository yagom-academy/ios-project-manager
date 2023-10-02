//
//  Observable.swift
//  ProjectManager
//
//  Created by BMO on 2023/10/01.
//

class Observable<T> {
    private var listener: ((T?) -> Void)?
    
    var value: T? {
        didSet {
            self.listener?(value)
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
