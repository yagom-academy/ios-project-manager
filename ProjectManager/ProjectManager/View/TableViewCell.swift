import UIKit

final class TableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func setup(title: String, body: String, date: Date) {
        titleLabel.text = title
        bodyLabel.text = body
        dateLabel.text = date.description
    }
}
