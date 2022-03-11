import UIKit

class ProjectHeader: UITableViewHeaderFooterView {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var totalCountLabel: UILabel!

    override func prepareForReuse() {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        totalCountLabel.textAlignment = .center
        totalCountLabel.backgroundColor = .black
        totalCountLabel.textColor = .white
        totalCountLabel.layer.cornerRadius = totalCountLabel.bounds.height / 2
        totalCountLabel.layer.masksToBounds = true
    }
}
