import UIKit

final class TaskTableViewCell: UITableViewCell {
    var task: Task?
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var bodyLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    override func prepareForReuse() {
        dateLabel.textColor = .black
        task = nil
    }
    
    func setup() {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .systemBlue
        selectedBackgroundView = backgroundView
    }
    
    func applyDate(with task: Task?) {
        self.task = task
        
        titleLabel.text = task?.title
        bodyLabel.text = task?.body
        
        if let dueDate = task?.dueDate {
            let dateText = DateFormatter.convertToString(from: dueDate)
            dateLabel.text = dateText
        }
    }
}
