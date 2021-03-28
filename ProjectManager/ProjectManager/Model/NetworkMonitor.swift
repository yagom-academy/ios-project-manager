//
//  NetworkMonitor.swift
//  ProjectManager
//
//  Created by 임성민 on 2021/03/24.
//

import Foundation
import Network

final class NetworkMonitor {
    static let shared = NetworkMonitor()
    private let networkMonitor = NWPathMonitor()
    private(set) var isConnected = false
    
    private init() {
        setNetworkMonitor()
    }
    
    private func setNetworkMonitor() {
        networkMonitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.isConnected = true
                NotificationCenter.default.post(name: NSNotification.Name(Strings.networkConnectNotification), object: nil)
            } else {
                self.isConnected = false
                NotificationCenter.default.post(name: NSNotification.Name(Strings.networkDisconnectNotification), object: nil)
            }
        }
        let queue = DispatchQueue(label: "NetworkMonitor")
        networkMonitor.start(queue: queue)
    }
}
