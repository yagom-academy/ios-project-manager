import UIKit
import RxSwift


protocol ProjectTableViewCellDelegate: AnyObject {
    
    func longpressed(at cell: ProjectTableViewCell)
    
}

private enum Content {
    
    static let moveToDoTitle = "Move to TODO"
    static let moveDoingTitle = "Move to DOING"
    static let moveDoneTitle = "Move to DONE"
    
}

private enum Design {
    
    static let verticalInset: CGFloat = 2
    
    static let tableViewBackgroundColor: UIColor = .systemGray5
    static let cellBackgroundColor: UIColor = .white
    static let textColor: UIColor = .label
    static let expiredDateColor: UIColor = .systemRed
    
}

final class ProjectTableViewCell: UITableViewCell {
    
    weak var delegate: ProjectTableViewCellDelegate?
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var bodyLabel: UILabel!
    @IBOutlet weak private var dateLabel: UILabel!
        
    private var work: Work?
    
    private var firstTitle: String {
        switch work?.category {
        case .todo:
            return Content.moveDoingTitle
        default:
            return Content.moveToDoTitle
        }
    }
    private var secondTitle: String {
        switch work?.category {
        case .done:
            return Content.moveDoingTitle
        default:
            return Content.moveDoneTitle
        }
    }
    
    override func awakeFromNib() {
        addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(showPopupMenu)))
    }
    
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

    func setupData(work: Work) {
        self.work = work
    }
    
    @objc private func showPopupMenu() {
        delegate?.longpressed(at: self)
    }
    
}
