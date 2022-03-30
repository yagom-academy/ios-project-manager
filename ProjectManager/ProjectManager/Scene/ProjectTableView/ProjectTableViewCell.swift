import UIKit
import RxSwift


// MARK: - DelegateProtocol
protocol ProjectTableViewCellDelegate: AnyObject {
    
    func longpressed(at cell: ProjectTableViewCell)
    
}

// MARK: - Namespace
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
    
    // MARK: - IBOutlet
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var bodyLabel: UILabel!
    @IBOutlet weak private var dateLabel: UILabel!
    
    // MARK: - properties
    weak var delegate: ProjectTableViewCellDelegate?
    private var work: Work?
    
    private var firstTitle: String {
        switch work?.categoryTag {
        case Work.Category.todo.tag:
            return Content.moveDoingTitle
        default:
            return Content.moveToDoTitle
        }
    }
    private var secondTitle: String {
        switch work?.categoryTag {
        case Work.Category.done.tag:
            return Content.moveDoingTitle
        default:
            return Content.moveDoneTitle
        }
    }
    
    // MARK: - Override Methods
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
    
    
    // MARK: - Methods
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
