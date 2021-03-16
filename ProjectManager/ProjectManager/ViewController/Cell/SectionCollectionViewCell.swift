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
    var board: Board?
    
    override func awakeFromNib() {
        registerXib()
        boardTableView.dragInteractionEnabled = true
        boardTableView.dragDelegate = self
        boardTableView.dropDelegate = self
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
            
            board.deleteTodoItem(at: indexPath.row)
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
        guard let board = board, let stringData = board.items[indexPath.row].title.data(using: .utf8) else {
            return []
        }

        let itemProvider = NSItemProvider(item: stringData as NSData, typeIdentifier: kUTTypePlainText as String)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        session.localContext = (board, indexPath, tableView)

        return [dragItem]
    }
}

extension SectionCollectionViewCell: UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        if coordinator.session.hasItemsConforming(toTypeIdentifiers: [kUTTypePlainText as String]) {
            coordinator.session.loadObjects(ofClass: NSString.self) { (items) in
                guard let string = items.first as? String else {
                    return
                }
                
                switch (coordinator.items.first?.sourceIndexPath, coordinator.destinationIndexPath) {
                case (.some(let sourceIndexPath), .some(let destinationIndexPath)):
                    // Same Table View
                    let updatedIndexPaths: [IndexPath]
                    if sourceIndexPath.row < destinationIndexPath.row {
                        print("1gogo")
                        updatedIndexPaths =  (sourceIndexPath.row...destinationIndexPath.row).map { IndexPath(row: $0, section: 0)
                        }
                        
                    } else if sourceIndexPath.row > destinationIndexPath.row {
                        print("2gogo")
                        updatedIndexPaths =  (destinationIndexPath.row...sourceIndexPath.row).map { IndexPath(row: $0, section: 0)
                        }
                    } else {
                        updatedIndexPaths = []
                        print("3gogo")
                    }
                    tableView.beginUpdates()
                    break
                    
                case (nil, .some(let destinationIndexPath)):
                    // Move data from a table to another table
                    self.removeSourceTableData(localContext: coordinator.session.localDragSession?.localContext)
                    break
                    
                    
                case (nil, nil):
                    // Insert data from a table to another table
                    self.removeSourceTableData(localContext: coordinator.session.localDragSession?.localContext)
                    break
                    
                default: break
                    
                }
            }
        }
    }
    
    func removeSourceTableData(localContext: Any?) {
        if let (dataSource, sourceIndexPath, tableView) = localContext as? (Board, IndexPath, UITableView) {
            tableView.beginUpdates()
            dataSource.items.remove(at: sourceIndexPath.row)
            tableView.deleteRows(at: [sourceIndexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }
    
}
