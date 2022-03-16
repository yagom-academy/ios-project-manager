import UIKit

final class TaskTableView: UITableView {
    var processStatus: ProcessStatus?
    
    func setupTableViewCell() {
        let nib = UINib(nibName: TaskTableViewCell.reuseIdentifier, bundle: nil)
        register(nib, forCellReuseIdentifier: TaskTableViewCell.reuseIdentifier)
        register(TaskTableHeaderView.self, forHeaderFooterViewReuseIdentifier: TaskTableHeaderView.reuseIdentifier)
    }
}
