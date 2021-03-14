import UIKit

protocol BoardTableViewCellDelegate: AnyObject {
    func tableViewCell(_ boardTableViewCell: BoardTableViewCell, didSelectAt index: Int, tappedCollectionViewCell: SectionCollectionViewCell)
}

class SectionCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var boardTableView: UITableView!
    weak var delegate: BoardTableViewCellDelegate?
    
    static let identifier = "SectionCollectionViewCell"
    
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
            switch self.boardTableView {
            case boardManager.boards[0]:
                Items.shared.deleteTodoItem(at: indexPath.row)
            case boardManager.boards[1]:
                Items.shared.deleteDoingItem(at: indexPath.row)
            default:
                Items.shared.deleteDoneItem(at: indexPath.row)
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension SectionCollectionViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.boardTableView {
        case boardManager.boards[0]:
            return Items.shared.todoList.count
        case boardManager.boards[1]:
            return Items.shared.doingList.count
        default:
            return Items.shared.doneList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BoardTableViewCell.identifier) as? BoardTableViewCell else {
            return UITableViewCell()
        }
        
        switch self.boardTableView {
        case boardManager.boards[0]:
            let todoItem = Items.shared.todoList[indexPath.row]
            cell.updateUI(with: todoItem)
        case boardManager.boards[1]:
            let doingItem = Items.shared.doingList[indexPath.row]
            cell.updateUI(with: doingItem)
        case boardManager.boards[2]:
            let doneItem = Items.shared.doneList[indexPath.row]
            cell.updateUI(with: doneItem)
        default:
            break
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .systemGray5
        
        let titleLabel = UILabel()
        
        switch self.boardTableView {
        case boardManager.boards[0]:
            titleLabel.text = ProgressStatus.todo.rawValue
        case boardManager.boards[1]:
            titleLabel.text = ProgressStatus.doing.rawValue
        default:
            titleLabel.text = ProgressStatus.done.rawValue
        }
        
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
