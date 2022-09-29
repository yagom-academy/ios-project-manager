//
//  NetworkObserver.swift
//  ProjectManager
//
//  Created by Groot on 2022/09/29.
//

import Network

class NetworkObserver {
    private let monitor: NWPathMonitor
    
    init() {
        self.monitor = NWPathMonitor()
    }
    
    func startMonitoring(completionHandler: @escaping (NWPath) -> Void) {
        monitor.start(queue: DispatchQueue.global())
        monitor.pathUpdateHandler = { path in
            completionHandler(path)
        }
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}
