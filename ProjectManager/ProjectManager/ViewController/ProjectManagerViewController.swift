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
    
    private func configureNavigationBar() {
        titleNavigationBar.topItem?.title = "Project Manager"
    }
    
    private func configureBoard() {
        let todoBoard = UITableView()
        let doingBoard = UITableView()
        let doneBoard = UITableView()
        
        BoardManager.shared.boards.append(todoBoard)
        BoardManager.shared.boards.append(doingBoard)
        BoardManager.shared.boards.append(doneBoard)
    }
    
    @IBAction func tappedAddButton(_ sender: Any) {
        presentSheetViewController()
    }
    
    func makeList() {
        Items.shared.todoList.append(Item(title: "TODO LIST", description: "TODO LIST for project. please help me!!", progressStatus: ProgressStatus.todo.rawValue, dueDate: 1220301220))
        
        Items.shared.doingList.append(Item(title: "DOING LIST", description: "DOING LIST for project. let's go party tonight!!", progressStatus: ProgressStatus.doing.rawValue, dueDate: 2220301220))
        
        Items.shared.doneList.append(Item(title: "DONE LIST", description: "DONE LIST for project. It's over over over again!!", progressStatus: ProgressStatus.done.rawValue, dueDate: 3220301220))
    }
}

extension ProjectManagerViewController: UICollectionViewDelegate {
    
}

extension ProjectManagerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return BoardManager.shared.boards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SectionCollectionViewCell.identifier, for: indexPath) as? SectionCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.boardTableView = BoardManager.shared.boards[indexPath.row]
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
        presentSheetViewController()
    }
}

extension ProjectManagerViewController {
    private func presentSheetViewController() {
        guard let sheetViewController = self.storyboard?.instantiateViewController(identifier: SheetViewController.identifier) else {
            return
        }
        
        sheetViewController.modalPresentationStyle = .formSheet
        self.present(sheetViewController, animated: true, completion: nil)
    }
}
