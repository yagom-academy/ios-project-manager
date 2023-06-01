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
            
            if path.status == .satisfied {
                print("연결잘됨!!")
            } else {
                print("연결안됨")
            }
        }
    }
    
    func stopMonitor() {
        monitor.cancel()
    }
}
