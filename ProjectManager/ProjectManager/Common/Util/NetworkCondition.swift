//
//  NetworkCondition.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/21.
//

import Reachability

final class NetworkCondition {
    static let sharedInstance: NetworkCondition = {
        return NetworkCondition()
    }()
    
    private let reachability: Reachability?
    
    private init() {
        self.reachability = try? Reachability()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(networkStatusChanged(_:)),
            name: .reachabilityChanged,
            object: reachability
        )
        
        guard let _ = try? reachability?.startNotifier() else {
            return
        }
    }
}

extension NetworkCondition {
    @objc func networkStatusChanged(_ notification: Notification) { }
    
    static func stopNotifier() {
        guard let reachability = NetworkCondition.sharedInstance.reachability,
              let _ = try? reachability.startNotifier() else {
            return
        }
    }
}
