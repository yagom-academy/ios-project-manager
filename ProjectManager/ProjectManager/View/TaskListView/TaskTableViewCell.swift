import UIKit

final class TaskTableViewCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var bodyLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    func applyDate(with task: Task) {
        titleLabel.text = task.title
        bodyLabel.text = task.body
        dateLabel.text = "\(task.dueDate)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dateLabel.textColor = .black
    }
}
