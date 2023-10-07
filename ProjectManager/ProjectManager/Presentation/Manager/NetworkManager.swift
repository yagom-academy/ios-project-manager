//
//  NetworkManager.swift
//  ProjectManager
//
//  Created by 김민성 on 2023/10/05.
//

import SwiftUI
import Network

// 시뮬레이터로 네트워크 테스트 확인 불가능
final class NetworkManager: ObservableObject {
    @Published var isConnected: Bool = false
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global()
    
    init() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
    }
}
