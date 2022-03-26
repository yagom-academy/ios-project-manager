import UIKit

final class TaskTableView: UITableView {}

final class TaskTableViewCell: UITableViewCell, Reusable {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()

        titleLabel.text = nil
        bodyLabel.text = nil
        dateLabel = nil
        isSelected = false
    }

    func updateUI(title: String, body: String, dueDate: String) {
        self.titleLabel?.text = title
        self.bodyLabel?.text = body
        self.dateLabel?.text = dueDate
    }
}
