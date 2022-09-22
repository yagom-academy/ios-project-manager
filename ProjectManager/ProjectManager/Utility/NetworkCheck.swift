//
//  NetworkCheck.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/22.
//

import UIKit
import Network

final class NetworkCheck {
    static let shared = NetworkCheck()
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    public private(set) var isConnected: Bool = false
    public private(set) var connectionType: ConnectionType = .unknown
    
    enum ConnectionType {
        case wifi
        case cellurar
        case ethernet
        case unknown
    }
    
    private init() {
        monitor = NWPathMonitor()
    }
    
    public func startMonitoring(in viewController: UIViewController) {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
            self?.getConnectionType(path)

            if self?.isConnected == true {
                print("연결됨")
            } else {
                print("연결안됨")
                let alert = UIAlertController(title: "인터넷 연결이 원활하지 않습니다.", message: "Wifi 또는 셀룰러를 활성화 해주세요.", preferredStyle: .alert)
                let confirm = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(confirm)
                DispatchQueue.main.async {
                    viewController.present(alert, animated: true)
                }
            }
        }
    }
    
    public func stopMonitoring() {
        monitor.cancel()
    }
    
    private func getConnectionType(_ path: NWPath) {
        if path.usesInterfaceType(.wifi) {
            connectionType = .wifi
        } else if path.usesInterfaceType(.cellular) {
            connectionType = .cellurar
        } else if path.usesInterfaceType(.wiredEthernet) {
            connectionType = .ethernet
        } else {
            connectionType = .unknown
        }
    }
}
