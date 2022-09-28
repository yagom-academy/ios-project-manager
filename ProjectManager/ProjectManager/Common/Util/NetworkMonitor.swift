//
//  NetworkMonitor.swift
//  ProjectManager
//
//  Created by seohyeon park on 2022/09/28.
//

import Foundation
import Network
import UIKit

class NetworkMonitor {
    static let shared = NetworkMonitor()

    private let monitor: NWPathMonitor
    private(set) var isConnected: Bool = false

    private init() {
        monitor = NWPathMonitor()
    }

    func startMonitoring() {
        let queue = DispatchQueue.global()
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = (path.status == .satisfied)
        }
    }

    func stopMonitoring() {
        monitor.cancel()
    }
}
