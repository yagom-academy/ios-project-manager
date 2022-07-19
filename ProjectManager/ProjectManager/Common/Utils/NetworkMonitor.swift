//
//  NetworkMonitor.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/19.
//

import Network
import Combine

final class NetworkMonitor {
    static let shared = NetworkMonitor()
    private init() {}
    
    private let monitor = NWPathMonitor()
    @Published private(set) var isConnected = false
    
    func start() {
        monitor.start(queue: .global())
        
        monitor.pathUpdateHandler = { [weak self] path in
            switch path.status {
            case .satisfied:
                self?.isConnected = true
            case .unsatisfied:
                self?.isConnected = false
            default:
                break
            }
        }
    }
}
