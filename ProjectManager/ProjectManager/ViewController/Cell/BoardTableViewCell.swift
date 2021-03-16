import UIKit

class BoardTableViewCell: UITableViewCell {
    static let identifier = "BoardTableViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    
    func updateUI(with item: Item) {
        self.titleLabel.text = item.title
        self.descriptionLabel.text = item.description
        self.dueDateLabel.text = item.dateToString
        
        func configureDueDateLabelColor() {
            let currentTimeInterval = Date().timeIntervalSince1970
            let currentDateToInt = Int(currentTimeInterval)
            
            if currentDateToInt > item.dueDate {
                self.dueDateLabel.textColor = .red
            } else {
                self.dueDateLabel.textColor = .black
            }
        }
        
        configureDueDateLabelColor()
    }
}
