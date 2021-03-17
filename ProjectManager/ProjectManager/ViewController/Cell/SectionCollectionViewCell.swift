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
    
    private var draggingRowIndex = 0
    private var draggingBoardIndex = 0
    
    let boardManager: BoardManager = BoardManager.shared
    
    weak var delegate: BoardTableViewCellDelegate?
    var board: Board?
    
    override func awakeFromNib() {
        registerXib()
        configureBoardTable()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTodoBoard), name: NSNotification.Name("reloadTodoBoard"), object: nil)
    }
    
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
    
    func configureBoard(with board: Board) {
        self.board = board
        sectionTitleLabel.text = "\(board.title) "
        boardItemCountLabel.text = "\(board.itemsCount)"
        boardItemCountLabel.textColor = .white
        boardItemCountLabel.textAlignment = .center
        boardItemCountLabel.backgroundColor = .black
        boardItemCountLabel.translatesAutoresizingMaskIntoConstraints = false
        boardItemCountLabel.layer.masksToBounds = true
        boardItemCountLabel.layer.cornerRadius = 10
    }
}

extension SectionCollectionViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedCell = tableView.cellForRow(at: indexPath) as? BoardTableViewCell else {
            return
        }
        
        self.delegate?.tableViewCell(selectedCell, didSelectAt: indexPath.row, on: board)
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
    
    @objc func reloadTodoBoard(_ noti: Notification) {
        boardTableView.reloadData()
    }
}

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

extension SectionCollectionViewCell: AddItemDelegate {
    func addNewCell(with item: Item) {
        if let board = self.board {
            board.addItem(item)
        }
    }
}

extension SectionCollectionViewCell: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let itemProvider = NSItemProvider()
        
        draggingRowIndex = indexPath.row
        
        switch self.board?.title {
        case ProgressStatus.todo.rawValue:
            draggingBoardIndex = 0
        case ProgressStatus.doing.rawValue:
            draggingBoardIndex = 1
        case ProgressStatus.done.rawValue:
            draggingBoardIndex = 2
        default:
            break
        }
        
        session.localContext = (board, indexPath, tableView)
        return [UIDragItem(itemProvider: itemProvider)]
    }
}

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
            
            if let board = self.board {
                board.insertItem(at: indexPath.row, with: boardManager.boards[draggingBoardIndex].item(at: draggingRowIndex))
                indexPaths.append(indexPath)
                tableView.insertRows(at: indexPaths, with: .automatic)
                configureBoard(with: board)
            }
            
            self.removeSourceTableData(localContext: coordinator.session.localDragSession?.localContext)
        }
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }
}
extension SectionCollectionViewCell {
    private func removeSourceTableData(localContext: Any?) {
        if let (dataSource, sourceIndexPath, tableView) = localContext as? (Board, IndexPath, UITableView) {
            tableView.beginUpdates()
            dataSource.deleteItem(at: sourceIndexPath.row)
            tableView.deleteRows(at: [sourceIndexPath], with: .automatic)
            NotificationCenter.default.post(name: NSNotification.Name("reloadHeader"), object: nil)
            tableView.endUpdates()
            tableView.reloadData()
        }
    }
}
