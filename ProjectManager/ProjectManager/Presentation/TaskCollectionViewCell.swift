import UIKit

class TaskCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var TaskListTitleLabel: UILabel!
    @IBOutlet weak var TaskListCountImageView: UIImageView!

    weak var parentViewController: TaskCollectionViewController?
    private var taskList: TaskListEntity?

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0))
    }

    func configure(with data: TaskListEntity) {
        self.taskList = data
        tableView.reloadData()
    }

    private func configureHeader() {
        TaskListTitleLabel.text = taskList?.title
        TaskListCountImageView.image = UIImage(systemName: "\(taskList?.items.count ?? 0).circle.fill")
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
        cell.titleLabel?.text = "\(String(describing: taskList?.items[indexPath.row]))"
        return cell
    }
}
