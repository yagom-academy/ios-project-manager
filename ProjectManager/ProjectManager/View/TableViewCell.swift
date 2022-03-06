import UIKit
import RxCocoa

final class TableViewCell: UITableViewCell {
    static let identifier = String(describing: self)
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
}
