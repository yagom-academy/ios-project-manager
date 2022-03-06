import UIKit
import RxCocoa

final class TableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
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
}
