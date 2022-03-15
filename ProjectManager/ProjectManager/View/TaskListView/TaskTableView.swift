import UIKit

final class TaskTableView: UITableView {
    private(set) var processStatus: ProcessStatus?
    var headerView: TaskTableHeaderView?
    
    func applyData(with processStatus: ProcessStatus) {
        self.processStatus = processStatus
        setupHeaderView(with: processStatus)
    }
    
    private func setupHeaderView(with processStatus: ProcessStatus) {
        headerView = TaskTableHeaderView(reuseIdentifier: TaskTableHeaderView.reuseIdentifier)
        headerView?.applyData(with: processStatus.description) // countLabel은 Subject 받고나서 지정 필요?
        self.tableHeaderView = headerView
    }
}
