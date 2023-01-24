//
//  NetworkMonitor.swift
//  ProjectManager
//
//  Created by 써니쿠키 on 2023/01/24.
//

import Foundation
import Network

protocol NetworkCheckerDelegate: AnyObject {
    
    func updateRemoteDataBase()
    func informUserOfNoNetwork()
}

final class NetworkMonitor {
    
    var delegate: NetworkCheckerDelegate?
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    private var isConnected: Bool = true {
        didSet {
            if isConnected {
                delegate?.updateRemoteDataBase()
            } else {
                delegate?.informUserOfNoNetwork()
            }
        }
    }
   
    init() {
        monitorNetworkChanges()
    }
    
    private func monitorNetworkChanges() {
        monitor.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied {
                self?.isConnected = true
            } else {
                self?.isConnected = false
            }
        }
        
        monitor.start(queue: queue)
    }
}
