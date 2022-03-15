import UIKit

final class TaskTableView: UITableView {
    private(set) var processStatus: ProcessStatus?
    
    func applyData(with processStatus: ProcessStatus) {
        self.processStatus = processStatus
    }
}
