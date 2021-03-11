import UIKit

class BoardTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    
    static let identifier = "BoardTableViewCell"
    
    func updateUI(with todoItem: TodoItem) {
        self.titleLabel.text = todoItem.title
        self.descriptionLabel.text = todoItem.description
        self.dueDateLabel.text = todoItem.dueDate
    }
}
