import Foundation
import Network

class NetworkCheckManager: ObservableObject {
    var isConnected: Bool = true
    private let monitor: NWPathMonitor
    private let queue = DispatchQueue(label: "monitor")
    
    init() {
        monitor = NWPathMonitor()
    }
    
    func startMonitoring(complition: @escaping (Bool) -> Void) {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
                complition(self?.isConnected ?? false)
            }
        }
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}
