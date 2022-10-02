//
//  NetworkMonitor.swift
//  ProjectManager
//
//  Created by Judy on 2022/09/23.
//

import RxSwift
import Network

final class NetWorkMonitor {
    static let shared = NetWorkMonitor()
    private let isOnNetwork = PublishSubject<Bool>()
    let networkObservable: Observable<Bool>
    
    private init() {
        networkObservable = isOnNetwork
    }
    
    func startCheckingNetwork() {
        let monitor = NWPathMonitor()
        
        monitor.start(queue: .global())
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.isOnNetwork.onNext(true)
            } else {
                self.isOnNetwork.onNext(false)
            }
        }
    }
}
