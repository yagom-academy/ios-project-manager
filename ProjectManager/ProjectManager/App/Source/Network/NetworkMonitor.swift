//
//  NetworkMonitor.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/31.
//

import Combine
import Network

final class NetworkMonitor {
    static let shared = NetworkMonitor()
    private let monitor = NWPathMonitor()
    @Published var isConnected = false
    
    private init() {}
    
    func startMonitor() {
        let globalQueue = DispatchQueue.global()
        
        monitor.start(queue: globalQueue)
        
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = (path.status == .satisfied)
        }
    }
    
    func stopMonitor() {
        monitor.cancel()
    }
}
