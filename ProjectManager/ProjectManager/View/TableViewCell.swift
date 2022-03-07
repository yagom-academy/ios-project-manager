import UIKit

final class TableViewCell: UITableViewCell {
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var bodyLabel: UILabel!
    @IBOutlet weak private var dateLabel: UILabel!
    
    override func prepareForReuse() {
        dateLabel.textColor = .label
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(
            top: 3,
            left: 0,
            bottom: 3,
            right: 0)
        )
        contentView.backgroundColor = .white
        self.backgroundColor = .systemGray5
    }
    
    func configureCellContent(for item: Work) {
        titleLabel.text = item.title
        bodyLabel.text = item.body
        dateLabel.text = item.convertedDate
        
        if item.isExpired {
            dateLabel.textColor = .systemRed
        }
    }
}
