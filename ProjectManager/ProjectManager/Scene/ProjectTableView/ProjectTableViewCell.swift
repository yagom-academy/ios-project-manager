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
    
    override func awakeFromNib() {
        addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(showPopupMenu)))
    }
    
    override func prepareForReuse() {
        dateLabel.textColor = Design.textColor
        
        titleLabel.text = nil
        bodyLabel.text = nil
        dateLabel.text = nil
    }
    
    override func layoutSubviews() { // 오토레이아웃이 변경되고 끝나면 불리게 된다. 이는 되게 신중하게 써야 한다. -> 변경과 맞물려있는 동작을 넣어줘야 한다. 변경될 때마다 불려야 하는 것이 들어가는 것이 좋다. 
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
