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

class NetworkChecker {
    
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
                  DispatchQueue.main.async {
                      if let window = UIApplication.shared.windows.first,
                      let rootViewController = window.rootViewController {
                          // 네트워크 연결상태 알림 띄우기
                      }
                  }
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
}
