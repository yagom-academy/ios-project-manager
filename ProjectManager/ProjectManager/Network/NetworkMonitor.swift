//
//  NetworkMonitor.swift
//  ProjectManager
//
//  Created by 써니쿠키 on 2023/01/24.
//

import Foundation
import Network

protocol NetworkMonitorDelegate: AnyObject {
    
    func handlingNetworkChanges(isConnected: Bool)
}

final class NetworkMonitor {
    
    var delegate: NetworkMonitorDelegate?
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    func monitorNetworkChanges() {
        monitor.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied {
                self?.delegate?.handlingNetworkChanges(isConnected: true)
            } else {
                self?.delegate?.handlingNetworkChanges(isConnected: false)

            }
        }
        
        monitor.start(queue: queue)
    }
}
