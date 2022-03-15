//import Foundation
//
//final class MockObservable<T> {
//    typealias Listener = (T) -> Void
//
//    var listener: Listener?
//
//    var value: T {
//        didSet {
//            listener?(value)
//        }
//    }
//
//    init(_ value: T) {
//        self.value = value
//    }
//
//    func bind(listener: Listener?) {
//        self.listener = listener
//        listener?(value)
//    }
//}
