import UIKit
import RxSwift


private enum Content {
    static let todoTitle = "TODO"
    static let doingTitle = "DOING"
    static let doneTitle = "DONE"
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
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var bodyLabel: UILabel!
    @IBOutlet weak private var dateLabel: UILabel!
    
    var title: String?
    var viewModel: ProjectViewModel?
    var work: Work?
    var viewController: ProjectTableViewController?
    
    var firstTitle: String {
        if title == Content.todoTitle {
            return Content.moveDoingTitle
        } else {
            return Content.moveToDoTitle
        }
    }
    var secondTitle: String {
        if title == Content.doneTitle {
            return Content.moveDoingTitle
        } else {
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
    
    @objc private func showPopupMenu() {
        guard let viewModel = viewModel else { return }

        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let firstAction = UIAlertAction(title: firstTitle, style: .default) { [weak self] _ in
            if self?.firstTitle == Content.moveToDoTitle {
                self?.change(category: .todo)
                viewModel.todoList.onNext(viewModel.workMemoryManager.todoList)
            } else {
                self?.change(category: .doing)
                viewModel.doingList.onNext(viewModel.workMemoryManager.doingList)
            }
        }
        let secondAction = UIAlertAction(title: secondTitle, style: .default) { [weak self] _ in
            if self?.secondTitle == Content.moveDoingTitle {
                self?.change(category: .doing)
                viewModel.doingList.onNext(viewModel.workMemoryManager.doingList)
            } else {
                self?.change(category: .done)
                viewModel.doneList.onNext(viewModel.workMemoryManager.doneList)
            }
        }

        alert.addAction(firstAction)
        alert.addAction(secondAction)
        alert.popoverPresentationController?.sourceView = self
        viewController?.present(alert, animated: true)
    }
    
    private func change(category: Work.Category) {
        guard let work = work else { return }

        viewModel?.updateWork(
            work,
            title: work.title,
            body: work.body,
            date: work.dueDate,
            category: category
        )
    }
    
}
