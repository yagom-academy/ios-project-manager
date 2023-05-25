//
//  Observable.swift
//  ProjectManager
//
//  Created by 무리 on 2023/05/26.
//

final class Observable<T> {
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    var listener: ((T) -> Void)?
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ listener: @escaping (T) -> Void) {
        listener(value)
        self.listener = listener
    }
}
