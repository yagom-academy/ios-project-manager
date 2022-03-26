//
//  NetworkChecker.swift
//  ProjectManager
//
//  Created by 1 on 2022/03/24.
//

import Foundation
import Network
import UIKit

public enum ConnectionType {
    case wifi
    case ethernet
    case cellular
    case unknown
}

final class NetworkChecker {
    
    static public let shared = NetworkChecker()
    private var monitor: NWPathMonitor
    private var queue = DispatchQueue.global()
    var isOn: Bool = true
    var connType: ConnectionType = .wifi
    
    private init() {
        self.monitor = NWPathMonitor()
        self.queue = DispatchQueue.global(qos: .background)
        self.monitor.start(queue: queue)
    }
    
    func start() {
        self.monitor.pathUpdateHandler = { path in
            self.isOn = path.status == .satisfied
            self.connType = self.checkConnectionTypeForPath(path)
            
            print("📡\(self.isOn)")
            
            if self.isOn == false {
                self.presentNetworkNotiAlertController()
            }
        }
        
    }
    
    
    func stop() {
        self.monitor.cancel()
    }
    
    func checkConnectionTypeForPath(_ path: NWPath) -> ConnectionType {
        if path.usesInterfaceType(.wifi) {
            return .wifi
        } else if path.usesInterfaceType(.wiredEthernet) {
            return .ethernet
        } else if path.usesInterfaceType(.cellular) {
            return .cellular
        }
        
        return .unknown
    }
    
    private func presentNetworkNotiAlertController() {
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.windows.first,
                  let rootViewController = window.rootViewController else {
                      return
                  }
            let alertController = UIAlertController(title: "네트워크 연결이 끊겼습니다",
                                                    message: "Cloud에 변경사항이 정상적으로 저장되지 않을 수 있어요😢",
                                                    preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            alertController.addAction(okAction)
            
            rootViewController.present(alertController, animated: false, completion: nil)
        }
    }
}
