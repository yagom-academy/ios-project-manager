import UIKit

class BoardTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    
    static let identifier = "BoardTableViewCell"
    
    func updateUI(with item: Item) {
        self.titleLabel.text = item.title
        self.descriptionLabel.text = item.description
        self.dueDateLabel.text = item.dateToString
        
        func checkDueDate() {
            let nowDate = Date()
            let nowTimeInterval = nowDate.timeIntervalSince1970
            let nowDateToInt = Int(nowTimeInterval)
            
            if nowDateToInt > item.dueDate {
                self.dueDateLabel.textColor = .red
            } else {
                self.dueDateLabel.textColor = .black
            }
        }
        
        checkDueDate()
    }
}
