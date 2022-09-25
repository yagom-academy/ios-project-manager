//
//  NetworkMonitor.swift
//  ProjectManager
//
//  Created by Judy on 2022/09/23.
//

import RxSwift
import Network

class NextWorkMonitor {
    static let shared = NextWorkMonitor()
    private let monitor = NWPathMonitor()
    private var isOnNetwork: Bool = false
    
    private init() { }
    
    func startCheckingNetwork() {
        monitor.start(queue: .global())
        
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.isOnNetwork = true
            } else {
                self.isOnNetwork = false
            }
        }
    }
    
    func checkNetwork() -> Observable<Bool> {
        return Observable.just(isOnNetwork)
    }
}
