import UIKit


private enum Design {
    static let verticalInset: CGFloat = 2
    static let tableViewBackgroundColor: UIColor = .systemGray5
    static let cellBackgroundColor: UIColor = .white
    static let textColor: UIColor = .label
    static let expiredDateColor: UIColor = .systemRed
}

final class ProjectTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var bodyLabel: UILabel!
    @IBOutlet weak private var dateLabel: UILabel!
    
    override func prepareForReuse() {
        dateLabel.textColor = Design.textColor
        
        titleLabel.text = nil
        bodyLabel.text = nil
        dateLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(
            top: Design.verticalInset,
            left: .zero,
            bottom: Design.verticalInset,
            right: .zero)
        )
        contentView.backgroundColor = Design.cellBackgroundColor
        self.backgroundColor = Design.tableViewBackgroundColor
    }
    
    func configureCellContent(for item: Work) {
        titleLabel.text = item.title
        bodyLabel.text = item.body
        dateLabel.text = item.convertedDate
        
        if item.isExpired {
            dateLabel.textColor = Design.expiredDateColor
        }
    }
    
}
