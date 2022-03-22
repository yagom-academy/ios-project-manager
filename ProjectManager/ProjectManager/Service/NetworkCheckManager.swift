import Foundation
import Network

class NetworkCheckManager: ObservableObject {
    var isConnected: Bool = true
    let monitor: NWPathMonitor
    let queue = DispatchQueue(label: "monitor")
    
    var delegate: NetWorkManagerDelegate?
    
    init() {
        monitor = NWPathMonitor()
        startMonitoring()
    }
    
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
                
                if self?.isConnected == true {
                    self?.delegate?.synchronizeFirebaseWithRealm()
                    print("연결됨")
                } else {
                    self?.delegate?.errorAlert = ErrorModel(message: "Network is Not Connected".localized())
                    print("연결안됨")
                }
            }
        }
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}
