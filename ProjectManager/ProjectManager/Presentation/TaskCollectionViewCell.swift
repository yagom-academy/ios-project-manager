import UIKit

class TaskCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var taskListTitleLabel: UILabel!
    @IBOutlet weak var taskListCountImageView: UIImageView!

    weak var parentViewController: TaskCollectionViewController?
    private var taskList: TaskList?

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0))
    }

    func configure(with data: TaskList) {
        self.taskList = data
        tableView.reloadData()
    }

    private func configureHeader() {
        taskListTitleLabel.text = taskList?.title
        taskListCountImageView.image = UIImage(systemName: "\(taskList?.items.count ?? 0).circle.fill")
    }
}

extension TaskCollectionViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        configureHeader()
        return taskList?.items.count ?? .zero
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "cell",
                for: indexPath) as? TaskTableViewCell else { return UITableViewCell() }
        if let task = taskList?.items[indexPath.row] {
            cell.titleLabel?.text = task.title
            cell.bodyLabel?.text = task.body
            cell.dateLabel?.text = task.dueDate
            return cell
        }
        return UITableViewCell()
    }
}
