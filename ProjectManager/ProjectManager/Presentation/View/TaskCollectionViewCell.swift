import UIKit

protocol TaskCollectionViewCellDelegate {
    func presentTaskDetailModal(taskListIndex: Int, taskIndex: Int?)
    func present(controller: UIViewController)
    func deleteTask(at index: Int, taskListIndex: Int)
}

final class TaskCollectionViewCell: UICollectionViewCell, Reusable {
    @IBOutlet weak private var tableView: TaskTableView!
    @IBOutlet weak private var taskListTitleLabel: UILabel!
    @IBOutlet weak private var taskListCountImageView: UIImageView?
    @IBOutlet weak private var addTaskButton: UIButton!

    var delegate: TaskCollectionViewCellDelegate?
    private var viewModel: TaskCellViewModel?

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.tableView = nil
        taskListTitleLabel.text = nil
        taskListCountImageView?.image = UIImage(systemName: "zero.circle.fill")
    }

    func configureCell(with viewModel: TaskCellViewModel?, _ taskListName: String, taskListIndex: Int) {
        self.viewModel = viewModel
        addTaskButton.tag = taskListIndex
        let taskItemsCount = self.viewModel?.countOfTaskItems(in: addTaskButton.tag) ?? .zero
        updateHeaderView(taskListName: taskListName, taskCount: taskItemsCount)
    }
    
    private func updateHeaderView(taskListName: String, taskCount: Int) {
        taskListCountImageView?.image = UIImage(systemName: "\(taskCount).circle.fill")
        taskListTitleLabel.text = taskListName
    }

    @IBAction private func addTaskButtonDidTap(_ sender: Any) {
        if let button = sender as? UIButton {
            delegate?.presentTaskDetailModal(taskListIndex: button.tag, taskIndex: nil)
        }
    }

    private func presentActionSheet(with indexPath: IndexPath) {
        let editAction = UIAlertAction(title: "Edit", style: .default) { [self] _ in
            delegate?.presentTaskDetailModal(taskListIndex: addTaskButton.tag, taskIndex: indexPath.row)
        }
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [self] _ in
            delegate?.deleteTask(at: indexPath.row, taskListIndex: addTaskButton.tag)
        }
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        let alertController = configureAlert(on: cell, with: [editAction, deleteAction])
        delegate?.present(controller: alertController)
    }

    private func configureAlert(on cell: UITableViewCell, with actions: [UIAlertAction]) -> UIAlertController {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.modalPresentationStyle = .popover
        alertController.popoverPresentationController?.sourceView = cell
        actions.forEach { alertController.addAction($0) }
        return alertController
    }
}

extension TaskCollectionViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let index = viewModel?.countOfTaskItems(in: addTaskButton.tag) ?? .zero
        return index
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.reuseIdentifier,
                                                    for: indexPath) as? TaskTableViewCell,
           let task = self.viewModel?.fetchTask(at: indexPath.row, in: addTaskButton.tag) {
            cell.updateUI(title: task.title, body: task.body, dueDate: task.dueDate)
            return cell
        }
        return UITableViewCell()
    }
}

extension TaskCollectionViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presentActionSheet(with: indexPath)
    }
}
