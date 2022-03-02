import UIKit

final class TableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0))
    }
    
    func setup(title: String, body: String, date: Date) {
        titleLabel.text = title
        bodyLabel.text = body
        dateLabel.text = date.description
    }
}
