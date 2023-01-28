//
//  NetworkMonitorManager.swift
//  ProjectManager
//
//  Created by junho lee on 2023/01/28.
//

import Foundation
import Network

final class NetworkMonitorManager {
    private let monitor = NWPathMonitor()
    var currentStatus: NWPath.Status {
        monitor.currentPath.status
    }
    var lastStatus = NWPath.Status.satisfied

    func startMonitoring(statusUpdateHandler: @escaping (NWPath.Status) -> Void) {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                statusUpdateHandler(path.status)
                self?.lastStatus = path.status
            }
        }
        monitor.start(queue: DispatchQueue.global())
    }

    func stopMonitoring() {
        monitor.cancel()
    }
}
