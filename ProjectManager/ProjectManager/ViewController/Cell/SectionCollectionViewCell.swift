import UIKit
import MobileCoreServices

protocol AddItemDelegate: AnyObject {
    func addNewCell(with item: Item)
}

class SectionCollectionViewCell: UICollectionViewCell {
    static let identifier = "SectionCollectionViewCell"
    
    @IBOutlet weak var boardTableView: UITableView!
    @IBOutlet weak var sectionTitleLabel: UILabel!
    @IBOutlet weak var boardItemCountLabel: UILabel!
    
    let pj = ProjectManagerViewController()
    var rowCount = UserDefaults.standard
    var boardCount = UserDefaults.standard
    
    weak var delegate: BoardTableViewCellDelegate?
    var board: Board?
    
    override func awakeFromNib() {
        registerXib()
        boardTableView.dragInteractionEnabled = true
        boardTableView.dragDelegate = self
        boardTableView.dropDelegate = self
        
        pj.addBoardItems()
    }
    
    private func registerXib(){
        let nibName = UINib(nibName: BoardTableViewCell.identifier, bundle: nil)
        boardTableView.register(nibName, forCellReuseIdentifier: BoardTableViewCell.identifier)
    }
    
    func configureBoard(with board: Board) {
        self.board = board
        sectionTitleLabel.text = "\(board.title) "
        boardItemCountLabel.text = "\(board.items.count)"
        boardItemCountLabel.textColor = .white
        boardItemCountLabel.layer.borderColor = UIColor.black.cgColor
        boardItemCountLabel.layer.borderWidth = 1
        boardItemCountLabel.layer.cornerRadius = 10
    }
}

extension SectionCollectionViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedCell = tableView.cellForRow(at: indexPath) as? BoardTableViewCell else {
            return
        }
        
        self.delegate?.tableViewCell(selectedCell, didSelectAt: indexPath.row, on : board)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let board = self.board else {
                return
            }
            
            board.deleteItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            configureBoard(with: board)
        }
    }
}

extension SectionCollectionViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BoardTableViewCell.identifier) as? BoardTableViewCell, let item = board?.items[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.updateUI(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return board?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

extension SectionCollectionViewCell: AddItemDelegate {
    func addNewCell(with item: Item) {
        guard let board = self.board else {
            return
        }
        
        board.addTodoItem(item)
        let indexPath = IndexPath(row:(board.items.count - 1), section:0)
        boardTableView.insertRows(at: [indexPath], with: .automatic)
        configureBoard(with: board)
    }
}

extension SectionCollectionViewCell: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let string = board?.title
        guard let data = string!.data(using: .utf8) else { return [] }
        let itemProvider = NSItemProvider(item: data as NSData, typeIdentifier: kUTTypePlainText as String)
        
        let indexRow = indexPath.row
        rowCount.setValue(indexRow, forKey: "indexCount")
        
        switch self.board?.title {
        case ProgressStatus.todo.rawValue:
            boardCount.setValue(0, forKey: "boardCount")
        case ProgressStatus.doing.rawValue:
            boardCount.setValue(1, forKey: "boardCount")
        case ProgressStatus.done.rawValue:
            boardCount.setValue(2, forKey: "boardCount")
        default:
            break
        }
        
        self.board?.items.remove(at: indexRow)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        configureBoard(with: self.board!)
        
        return [UIDragItem(itemProvider: itemProvider)]
    }
}

extension SectionCollectionViewCell: UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        let destinationIndexPath: IndexPath
        
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let section = tableView.numberOfSections - 1
            let row = tableView.numberOfRows(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }
        
        coordinator.session.loadObjects(ofClass: NSString.self) { [self] items in
            guard let strings = items as? [String] else { return }

            var indexPaths = [IndexPath]()

            for index in 0..<strings.count {
                let indexPath = IndexPath(row: destinationIndexPath.row + index, section: destinationIndexPath.section)
                
                let count = self.rowCount.integer(forKey: "indexCount")
                let boardNumber = self.boardCount.integer(forKey: "boardCount")
                
                self.board?.items.insert(pj.boards[boardNumber].items[count], at: indexPath.row)
                
                indexPaths.append(indexPath)
            }
            tableView.insertRows(at: indexPaths, with: .automatic)
            configureBoard(with: self.board!)
        }
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }
}

