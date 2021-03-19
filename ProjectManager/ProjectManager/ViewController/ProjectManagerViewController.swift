import UIKit
import MobileCoreServices

protocol BoardTableViewCellDelegate: AnyObject {
    func tableViewCell(_ boardTableViewCell: BoardTableViewCell, didSelectAt index: Int, on board: Board?)
}

class ProjectManagerViewController: UIViewController {
    @IBOutlet weak var titleNavigationBar: UINavigationBar!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var sectionCollectionView: UICollectionView!
    
    weak var delegate: AddItemDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        //        createFile()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadHeader), name: NSNotification.Name("reloadHeader"), object: nil)
    }
    
    @IBAction func tappedAddButton(_ sender: Any) {
        createNewTodoItem()
    }
    
    @objc func reloadHeader(_ noti: Notification) {
        for item in 0..<sectionCollectionView.numberOfItems(inSection: 0) {
            if let sectionCollectionViewCell = sectionCollectionView.cellForItem(at: [0,item]) as? SectionCollectionViewCell, let cellBoard = sectionCollectionViewCell.board {
                sectionCollectionViewCell.updateHeaderLabels(with: cellBoard)
            }
        }
    }
}

// MARK: - UIColletionViewDataSource

extension ProjectManagerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return boardManager.boards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SectionCollectionViewCell.identifier, for: indexPath) as? SectionCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.updateHeaderLabels(with : boardManager.boards[indexPath.item])
        cell.delegate = self
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ProjectManagerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionViewCellWidth = collectionView.frame.width / CGFloat(boardManager.boards.count) - 10
        let collectionViewCellHeight = collectionView.frame.height
        
        return CGSize(width: collectionViewCellWidth, height: collectionViewCellHeight)
    }
}

// MARK: - UIDropInteractionDelegate

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
                
                self.deleteDraggedItem(localDragSession: session.localDragSession)
            }
        }
    }
}

// MARK: - BoardTableViewCellDelegate

extension ProjectManagerViewController: BoardTableViewCellDelegate {
    func tableViewCell(_ boardTableViewCell: BoardTableViewCell, didSelectAt index: Int, on board: Board?) {
        if let board = board {
            updateItem(in: boardTableViewCell, at: index, on: board)
        }
    }
}

// MARK: - Extension ProjectManagerViewController

extension ProjectManagerViewController {
    private func configureNavigationBar() {
        titleNavigationBar.topItem?.title = "Project Manager"
    }
    
    private func createNewTodoItem() {
        var newItem = boardManager.todoBoard.createItem()
        let presentedSheetViewController = presentSheetViewController(with: newItem, mode: Mode.editable)
        
        presentedSheetViewController.updateItemHandler { (currentItem) in
            newItem = currentItem
            self.delegate = self.sectionCollectionView.cellForItem(at: [0,0]) as? SectionCollectionViewCell
            self.delegate?.addNewCell(with: newItem)
        }
    }
    
    private func updateItem(in boardTableViewCell: BoardTableViewCell, at index: Int, on board: Board) {
        let item = board.item(at: index)
        let presentedSheetViewController = presentSheetViewController(with: item, mode: Mode.readOnly)
        
        presentedSheetViewController.updateItemHandler { (currentItem) in
            board.updateItem(at: index, with: currentItem)
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
    
    private func deleteDraggedItem(localDragSession: UIDragSession?) {
        if let (board, sourceIndexPath, tableView) = localDragSession?.localContext as? (Board, IndexPath, UITableView) {
            board.deleteItem(at: sourceIndexPath.row)
            tableView.deleteRows(at: [sourceIndexPath], with: .automatic)
        }
    }
}

// MARK: - Create Local Disk Cache

extension ProjectManagerViewController {
    func createFile() {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent("JSONFile.json")
        //        let text = NSString(string: jsonString)
        //        try? text.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8.rawValue)
        
        print(fileURL)
    }
}

extension ProjectManagerViewController {
    @IBAction func showHistory(_ sender: Any) {
    }
}
