import UIKit

class ProjectHeader: UITableViewHeaderFooterView {
    static let nibName = "ProjectHeader"
    static let identifier = "projectHeader"
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var totalCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        totalCountLabel.textAlignment = .center
        totalCountLabel.backgroundColor = .black
        totalCountLabel.textColor = .white
        totalCountLabel.layer.cornerRadius = totalCountLabel.bounds.height / 2
        totalCountLabel.layer.masksToBounds = true
    }
    
    func configure(title: String, count: Int) {
        titleLabel.text = title
        totalCountLabel.text = count.description
    }
}
