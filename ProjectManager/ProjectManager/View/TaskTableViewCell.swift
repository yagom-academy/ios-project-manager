import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
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
