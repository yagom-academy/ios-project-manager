//
//  NetworkMonitor.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/30.
//

import Network

struct NetworkMonitor {
    private let backgroundQueue = DispatchQueue.global(qos: .utility)
    private let monitor = NWPathMonitor()
    
    func checkNetworkState(_ handler: @escaping (Bool) -> Void) {
        monitor.start(queue: backgroundQueue)
        monitor.pathUpdateHandler = { path in
            guard path.status == .satisfied else {
                handler(false)
                return
            }
            
            handler(true)
        }
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}
