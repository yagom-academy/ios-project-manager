//
//  NetworkObserver.swift
//  ProjectManager
//
//  Created by dhoney96 on 2022/09/28.
//

import Foundation
import Network

final class NetworkObserver {
    static let shared = NetworkObserver()
    private let monitor: NWPathMonitor
    
    private init() {
        self.monitor = NWPathMonitor()
    }
    
    func startObserving(completion: @escaping ((Bool) -> Void)) {
        monitor.start(queue: DispatchQueue.global())
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func stopObserving() {
        monitor.cancel()
    }
}
