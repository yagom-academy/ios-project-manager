import UIKit

class ProjectTableViewCell: UITableViewCell {
    static let identifier = String(describing: self)
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.textAlignment = .left
        return label
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .gray
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .callout)
        label.textAlignment = .left
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 7, left: 0, bottom: 0, right: 0))
        contentView.backgroundColor = .white
        self.backgroundColor = .systemGray6
    }
    
    private func configureUI() {
        [titleLabel, bodyLabel, dateLabel].forEach {
            self.contentView.addSubview($0)
        }
    }
}
