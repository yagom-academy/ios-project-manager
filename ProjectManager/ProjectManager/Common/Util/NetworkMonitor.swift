//
//  NetworkMonitor.swift
//  ProjectManager
//
//  Created by seohyeon park on 2022/09/28.
//

import Foundation
import Network

class NetworkMonitor {
    static let shared = NetworkMonitor()

    private let monitor: NWPathMonitor
    private(set) var isConnected: Bool = false

    private init() {
        monitor = NWPathMonitor()
    }

    func startMonitoring() {
        monitor.start(queue: .global())
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = (path.status == .satisfied)

            if self?.isConnected == false {
                self?.notifyDisconnect()
            }
        }
    }

    func stopMonitoring() {
        monitor.cancel()
    }

    private func notifyDisconnect() {
        NotificationCenter.default.post(name: NSNotification.Name("disconnect"), object: nil)
    }
}
