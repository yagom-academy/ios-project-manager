//
//  NetworkManager.swift
//  ProjectManager
//
//  Created by Derrick kim on 2022/09/22.
//

import Foundation
import Network

final class NetworkManager {
    static let shared = NetworkManager()

    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    public private(set) var isConnected: Bool = false

    private init() {
        monitor = NWPathMonitor()
    }
    
    public func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
        }
    }
}
