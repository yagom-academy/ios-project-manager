import UIKit
import MobileCoreServices

protocol BoardTableViewCellDelegate: AnyObject {
    func tableViewCell(_ boardTableViewCell: BoardTableViewCell, didSelectAt index: Int, on board: Board?)
}

class ProjectManagerViewController: UIViewController {
    @IBOutlet weak var titleNavigationBar: UINavigationBar!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var sectionCollectionView: UICollectionView!
    
    let todoBoard = Board(title: ProgressStatus.todo.rawValue)
    let doingBoard = Board(title: ProgressStatus.doing.rawValue)
    let doneBoard = Board(title: ProgressStatus.done.rawValue)
    lazy var boards: [Board] = {
        return [todoBoard, doingBoard, doneBoard]
    }()
    
    weak var delegate: AddItemDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        addBoardItems()
    }
    
    @IBAction func tappedAddButton(_ sender: Any) {
        createNewTodoItem()
    }
    
    private func configureNavigationBar() {
        titleNavigationBar.topItem?.title = "Project Manager"
    }
    
    private func addBoardItems() {
        todoBoard.items.append(Item(title: "TODO LIST", description: "TODO LIST for project. please help me!!", progressStatus: ProgressStatus.todo.rawValue, dueDate: 1220301220))
        todoBoard.items.append(Item(title: "TODO LIST2", description: "TODO LIST for project. please help me!!", progressStatus: ProgressStatus.todo.rawValue, dueDate: 1220301220))
        todoBoard.items.append(Item(title: "TODO LIST3", description: "TODO LIST for project. please help me!!", progressStatus: ProgressStatus.todo.rawValue, dueDate: 1220301220))
        doingBoard.items.append(Item(title: "DOing LIST", description: "TODO LIST for project. please help me!!", progressStatus: ProgressStatus.todo.rawValue, dueDate: 1220301220))
        doingBoard.items.append(Item(title: "DOing LIST2", description: "TODO LIST for project. please help me!!", progressStatus: ProgressStatus.todo.rawValue, dueDate: 1220301220))
        doingBoard.items.append(Item(title: "DOing LIST3", description: "TODO LIST for project. please help me!!", progressStatus: ProgressStatus.todo.rawValue, dueDate: 1220301220))
        doneBoard.items.append(Item(title: "DONE LIST", description: "Done LIST for project. please help me!!", progressStatus: ProgressStatus.todo.rawValue, dueDate: 1220301220))
        doneBoard.items.append(Item(title: "DONE LIST2", description: "Done LIST for project. please help me!!", progressStatus: ProgressStatus.todo.rawValue, dueDate: 1220301220))
        doneBoard.items.append(Item(title: "DONE LIST3", description: "Done LIST for project. please help me!!", progressStatus: ProgressStatus.todo.rawValue, dueDate: 1220301220))
    }
}

extension ProjectManagerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return boards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SectionCollectionViewCell.identifier, for: indexPath) as? SectionCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configureBoard(with : boards[indexPath.item])
        cell.delegate = self
        return cell
    }
}

extension ProjectManagerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionViewCellWidth = collectionView.frame.width / CGFloat(boards.count) - 10
        let collectionViewCellHeight = collectionView.frame.height
        
        return CGSize(width: collectionViewCellWidth, height: collectionViewCellHeight)
    }
}

extension ProjectManagerViewController: BoardTableViewCellDelegate {
    func tableViewCell(_ boardTableViewCell: BoardTableViewCell, didSelectAt index: Int, on board: Board?) {
        if let board = board {
            updateItem(with: board.items[index], in: boardTableViewCell, at: index, on: board)
        }
    }
}

extension ProjectManagerViewController {
    private func createNewTodoItem() {
        var newItem = todoBoard.createItem()
        let presentedSheetViewController = presentSheetViewController(with: newItem, mode: Mode.editable)
        
        presentedSheetViewController.updateItemHandler { (currentItem) in
            newItem = currentItem
            self.delegate = self.sectionCollectionView.cellForItem(at: [0,0]) as? SectionCollectionViewCell
            self.delegate?.addNewCell(with: newItem)
        }
    }
    
    private func updateItem(with item: Item, in boardTableViewCell: BoardTableViewCell, at index: Int, on board: Board) {
        let presentedSheetViewController = presentSheetViewController(with: item, mode: Mode.uneditable)
        
        presentedSheetViewController.updateItemHandler { (currentItem) in
            board.updateTodoItem(at: index, with: currentItem)
            boardTableViewCell.updateUI(with: currentItem)
        }
    }
    
    private func presentSheetViewController(with item: Item, mode: Mode) -> SheetViewController {
        guard let sheetViewController = self.storyboard?.instantiateViewController(identifier: SheetViewController.identifier) as? SheetViewController else {
            return SheetViewController()
        }
        
        sheetViewController.modalPresentationStyle = .formSheet
        sheetViewController.setItem(with: item)
        sheetViewController.mode = mode
        self.present(sheetViewController, animated: true, completion: nil)
        
        return sheetViewController
    }
}

extension ProjectManagerViewController: UIDropInteractionDelegate {
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .move)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        if session.hasItemsConforming(toTypeIdentifiers: [kUTTypePlainText as String]) {
            session.loadObjects(ofClass: NSString.self) { (items) in
                guard let _ = items.first as? String else {
                    return
                }
                
                if let (dataSource, sourceIndexPath, tableView) = session.localDragSession?.localContext as? (Board, IndexPath, UITableView) {
                    tableView.beginUpdates()
                    dataSource.items.remove(at: sourceIndexPath.row)
                    tableView.deleteRows(at: [sourceIndexPath], with: .automatic)
                    tableView.endUpdates()
                }
            }
        }
    }
}
