import UIKit

final class TaskCollectionViewCell: UICollectionViewCell, Reusable {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var taskListTitleLabel: UILabel!
    @IBOutlet weak var taskListCountImageView: UIImageView!

    private var taskList: TaskList?

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0))
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        taskListTitleLabel.text = nil
        taskListCountImageView = nil
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
                withIdentifier: TaskTableViewCell.reuseIdentifier,
                for: indexPath) as? TaskTableViewCell else { return UITableViewCell() }
        guard let task = taskList?.items[safe: indexPath.row] else { return UITableViewCell() }
        cell.updateData(with: task)
        return cell
    }
}

extension TaskTableViewCell {
    func updateData(with task: Task) {
        self.titleLabel?.text = task.title
        self.bodyLabel?.text = task.body
        self.dateLabel?.text = task.dueDate
    }
}
