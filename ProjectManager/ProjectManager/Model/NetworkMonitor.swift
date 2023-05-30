//
//  NetworkMonitor.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/30.
//

import Network

final class NetworkMonitor {
    private let backgroundQueue = DispatchQueue.global(qos: .background)
    private let monitor = NWPathMonitor()
    
    func checkNetworkState() {
        monitor.start(queue: backgroundQueue)
        monitor.pathUpdateHandler = { path in
            print("path: \(path)")
            
            if path.status == .satisfied {
                print("연결")
            } else {
                print("연결 안되")
            }
        }
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}
