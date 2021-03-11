import UIKit

protocol BoardTableViewCellDelegate: AnyObject {
    func tableViewCell(_ boardTableViewCell: BoardTableViewCell, didSelectAt index: Int, tappedCollectionViewCell: SectionCollectionViewCell)
}

class SectionCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var boardTableView: UITableView!
    weak var delegate: BoardTableViewCellDelegate?
    
    static let identifier = "SectionCollectionViewCell"
    
    var todoList = [TodoItem(title: "title1", description: "storyboard file instead.UIKit separates the content of your view controllers from the way that content is presented and displayed onscreen. Presented view controllers are managed by an underlying presentation controller object, which manages the visual style used to display the view controller’s view. A presentation controller may do the following:Set the size of the presented view controller.Add custom views to change the visual appearance of the presented content.Supply transition animations for any of its custom views.Adapt the visual appearance of the presentation when changes occur in the app’s environment.UIKit provides presentation controllers for the standard presentation styles. When you set the presentation style of a view controller to UIModalPresentationCustom and provide an appropriate transitioning delegate, UIKit uses your custom presentation controller instead.", dueDate: "2020.12.12", progressStatus: .doing),
                    TodoItem(title: "title2", description: "storyboard file", dueDate: "2020.12.13", progressStatus: .done),
                    TodoItem(title: "title3", description: "storyboard filestoryboard filestoryboard file", dueDate: "2020.12.14", progressStatus: .todo),
                    TodoItem(title: "title4", description: " storyboard file instead.UIKit separates the content of your view controllers from the way that content is presented and displayed onscreen. Presented view controllers are managed by an underlying presentation controller object, which manages ", dueDate: "2020.12.22", progressStatus: .todo),
                    TodoItem(title: "title5", description: "Project Manager", dueDate: "2020.12.31", progressStatus: .doing)]
    
    let doingList = [TodoItem(title: "title1-1", description: "test", dueDate: "2020.12.12", progressStatus: .doing), TodoItem(title: "title1-1", description: "test", dueDate: "2020.12.12", progressStatus: .doing), TodoItem(title: "title1-1", description: "test", dueDate: "2020.12.12", progressStatus: .doing), TodoItem(title: "title1-1", description: "test", dueDate: "2020.12.12", progressStatus: .doing), TodoItem(title: "title1-1", description: "test", dueDate: "2020.12.12", progressStatus: .doing)]
    
    override func awakeFromNib() {
        registerXib()
    }
    
    private func registerXib(){
        let nibName = UINib(nibName: BoardTableViewCell.identifier, bundle: nil)
        boardTableView.register(nibName, forCellReuseIdentifier: BoardTableViewCell.identifier)
    }
}

extension SectionCollectionViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedCell = tableView.cellForRow(at: indexPath) as? BoardTableViewCell else {
            return
        }
        
        self.delegate?.tableViewCell(selectedCell, didSelectAt: indexPath.row, tappedCollectionViewCell: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todoList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension SectionCollectionViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BoardTableViewCell.identifier) as? BoardTableViewCell else {
            return UITableViewCell()
        }
        
        let todoItem = todoList[indexPath.row]
        cell.updateUI(with: todoItem)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .systemGray5
        
        let titleLabel = UILabel()
        titleLabel.text = "TODO"
        titleLabel.font = .preferredFont(forTextStyle: .largeTitle)
        
        headerView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
