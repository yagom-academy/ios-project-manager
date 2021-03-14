import UIKit

class ProjectManagerViewController: UIViewController {
    @IBOutlet weak var titleNavigationBar: UINavigationBar!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var sectionCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureBoard()
        makeList()
    }
    
    @IBAction func tappedAddButton(_ sender: Any) {
        createNewTodoItem()
    }
    
    private func configureNavigationBar() {
        titleNavigationBar.topItem?.title = "Project Manager"
    }
    
    private func configureBoard() {
        let todoBoard = UITableView()
        let doingBoard = UITableView()
        let doneBoard = UITableView()
        
        boardManager.boards.append(todoBoard)
        boardManager.boards.append(doingBoard)
        boardManager.boards.append(doneBoard)
    }
    
    private func makeList() {
        itemManager.todoList.append(Item(title: "TODO LIST", description: "TODO LIST for project. please help me!!", progressStatus: ProgressStatus.todo.rawValue, dueDate: 1220301220))
        
        itemManager.doingList.append(Item(title: "DOING LIST", description: "DOING LIST for project. let's go party tonight!!", progressStatus: ProgressStatus.doing.rawValue, dueDate: 2220301220))
        
        itemManager.doneList.append(Item(title: "DONE LIST", description: "DONE LIST for project. It's over over over again!!", progressStatus: ProgressStatus.done.rawValue, dueDate: 3220301220))
    }
}

extension ProjectManagerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return boardManager.boards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SectionCollectionViewCell.identifier, for: indexPath) as? SectionCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.boardTableView = boardManager.boards[indexPath.row]
        cell.delegate = self
        return cell
    }
}

extension ProjectManagerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionViewCellWidth = collectionView.frame.width / 3.08
        let collectionViewCellHeight = collectionView.frame.height
        
        return CGSize(width: collectionViewCellWidth, height: collectionViewCellHeight)
    }
}

extension ProjectManagerViewController: BoardTableViewCellDelegate {
    func tableViewCell(_ boardTableViewCell: BoardTableViewCell, didSelectAt index: Int, tappedCollectionViewCell: SectionCollectionViewCell) {
        switch tappedCollectionViewCell.boardTableView {
        case boardManager.boards[0]:
            updateItem(with: itemManager.todoList[index], in: boardTableViewCell, at: index, sectionCollectionViewCell: tappedCollectionViewCell)
        case boardManager.boards[1]:
            updateItem(with: itemManager.doingList[index], in: boardTableViewCell, at: index, sectionCollectionViewCell: tappedCollectionViewCell)
        case boardManager.boards[2]:
            updateItem(with: itemManager.doneList[index], in: boardTableViewCell, at: index, sectionCollectionViewCell: tappedCollectionViewCell)
        default:
            break
        }
    }
}
extension ProjectManagerViewController {
    private func createNewTodoItem() {
        var newItem = itemManager.createItem("", "", dueDate: Int(Date().timeIntervalSince1970))
        let presentedSheetViewController = presentSheetViewController(with: newItem)
        
        presentedSheetViewController.updateItemHandler { (currentItem) in
            newItem = currentItem
            itemManager.todoList.append(newItem)
        }
    }
    
    private func updateItem(with item: Item, in boardTableViewCell: BoardTableViewCell, at index: Int, sectionCollectionViewCell: SectionCollectionViewCell) {
        let presentedSheetViewController = presentSheetViewController(with: item)
        
        presentedSheetViewController.updateItemHandler { (currentItem) in
            switch sectionCollectionViewCell.boardTableView {
            case boardManager.boards[0]:
                itemManager.updateTodoItem(at: index, with: currentItem)
            case boardManager.boards[1]:
                itemManager.updateDoingItem(at: index, with: currentItem)
            case boardManager.boards[2]:
                itemManager.updateDoneItem(at: index, with: currentItem)
            default:
                break
            }
            
            boardTableViewCell.updateUI(with: currentItem)
        }
    }
    
    private func presentSheetViewController(with item: Item) -> SheetViewController {
        guard let sheetViewController = self.storyboard?.instantiateViewController(identifier: SheetViewController.identifier) as? SheetViewController else {
            return SheetViewController()
        }
        
        sheetViewController.modalPresentationStyle = .formSheet
        sheetViewController.setItem(with: item)
        sheetViewController.mode = Mode.new
        self.present(sheetViewController, animated: true, completion: nil)
        
        return sheetViewController
    }
}
