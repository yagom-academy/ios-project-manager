//
//  File.swift
//  ProjectManager
//
//  Created by Lee Seung-Jae on 2022/03/16.
//

import Foundation
import RxSwift
import Network

final class NetworkChecker {
    static let shared = NetworkChecker()
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor

    private(set) var isConnected: Observable<Bool>

    private init() {
        self.monitor = NWPathMonitor()
        self.isConnected = Observable.just(false)
    }

    func startMonitoring() {
        let connectingObservable = BehaviorSubject<Bool>(value: false)
        self.isConnected = connectingObservable
        self.monitor.start(queue: queue)
        self.monitor.pathUpdateHandler = { path in
            connectingObservable.onNext(path.status == .satisfied)
        }
    }

    func stopMonitoring() {
        self.monitor.cancel()
    }
}
