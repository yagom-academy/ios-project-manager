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
    
    weak var delegate: BoardTableViewCellDelegate?
    var rowCount = UserDefaults.standard
    var boardCount = UserDefaults.standard
    var board: Board?
    
    override func awakeFromNib() {
        registerXib()
        configureBoardTable()
        updateHeaderUI()
    }
    
    func updateHeaderLabels(with board: Board) {
        self.board = board
        sectionTitleLabel.text = "\(board.title) "
        boardItemCountLabel.text = "\(board.itemsCount)"
    }
}

// MARK: - UITableViewDelegate

extension SectionCollectionViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedCell = tableView.cellForRow(at: indexPath) as? BoardTableViewCell else {
            return
        }
        
        self.delegate?.tableViewCell(selectedCell, didSelectAt: indexPath.row, on: board)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let board = self.board else {
            return
        }
        
        if editingStyle == .delete {
            board.deleteItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            updateHeaderLabels(with: board)
        }
    }
}

// MARK: - UITableViewDataSource

extension SectionCollectionViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BoardTableViewCell.identifier) as? BoardTableViewCell, let item = board?.item(at: indexPath.row) else {
            return UITableViewCell()
        }
        
        cell.updateUI(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return board?.itemsCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if let board = self.board {
            let movingItem = board.item(at: sourceIndexPath.row)
            board.deleteItem(at: sourceIndexPath.row)
            board.insertItem(at: destinationIndexPath.row, with: movingItem)
        }
    }
}

// MARK: - UITableViewDragDelegate

extension SectionCollectionViewCell: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let itemProvider = NSItemProvider()
        
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
        
        session.localContext = (board, indexPath, tableView)
        return [UIDragItem(itemProvider: itemProvider)]
    }
}

// MARK: - UITableViewDropDelegate

extension SectionCollectionViewCell: UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        let destinationIndexPath: IndexPath
        
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let row = tableView.numberOfRows(inSection: 0)
            destinationIndexPath = IndexPath(row: row, section: 0)
        }
        
        coordinator.session.loadObjects(ofClass: NSString.self) { [self] items in
            var indexPaths = [IndexPath]()
            let indexPath = IndexPath(row: destinationIndexPath.row, section: destinationIndexPath.section)
            
            let count = self.rowCount.integer(forKey: "indexCount")
            let boardNumber = self.boardCount.integer(forKey: "boardCount")
            
            if let board = self.board {
                board.insertItem(at: indexPath.row, with: boardManager.boards[boardNumber].item(at: count))
                indexPaths.append(indexPath)
                tableView.insertRows(at: indexPaths, with: .automatic)
                updateHeaderLabels(with: board)
            }
            
            self.removeSourceTableData(localContext: coordinator.session.localDragSession?.localContext)
        }
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }
}

// MARK: - AddItemDelegate

extension SectionCollectionViewCell: AddItemDelegate {
    func addNewCell(with item: Item) {
        if let board = self.board {
            board.addItem(item)
            boardTableView.insertRows(at: [IndexPath(row: board.itemsCount - 1, section: 0)], with: .automatic)
            updateHeaderLabels(with: board)
        }
    }
}

// MARK: - Extension SectionCollectionViewCell

extension SectionCollectionViewCell {
    private func registerXib(){
        let nibName = UINib(nibName: BoardTableViewCell.identifier, bundle: nil)
        boardTableView.register(nibName, forCellReuseIdentifier: BoardTableViewCell.identifier)
    }
    
    private func configureBoardTable() {
        boardTableView.dragInteractionEnabled = true
        boardTableView.dragDelegate = self
        boardTableView.dropDelegate = self
        boardTableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    private func updateHeaderUI() {
        boardItemCountLabel.textColor = .white
        boardItemCountLabel.textAlignment = .center
        boardItemCountLabel.backgroundColor = .black
        boardItemCountLabel.translatesAutoresizingMaskIntoConstraints = false
        boardItemCountLabel.layer.masksToBounds = true
        boardItemCountLabel.layer.cornerRadius = 10
    }
    
    private func removeSourceTableData(localContext: Any?) {
        if let (dataSource, sourceIndexPath, tableView) = localContext as? (Board, IndexPath, UITableView) {
            dataSource.deleteItem(at: sourceIndexPath.row)
            tableView.deleteRows(at: [sourceIndexPath], with: .automatic)
            NotificationCenter.default.post(name: NSNotification.Name("reloadHeader"), object: nil)
        }
    }
}
