import UIKit

class ProjectManagerViewController: UIViewController {
    @IBOutlet weak var titleNavigationBar: UINavigationBar!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var sectionCollectionView: UICollectionView!
    var boards = [Board]()
    weak var delegate: AddItemDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureBoards()
    }
    
    @IBAction func tappedAddButton(_ sender: Any) {
        createNewTodoItem()
    }
    
    private func configureNavigationBar() {
        titleNavigationBar.topItem?.title = "Project Manager"
    }
    
    private func configureBoards() {
       boards = [Board(title: "TODO", items: [Item(title: "TODO LIST", description: "TODO LIST for project. please help me!!", progressStatus: ProgressStatus.todo.rawValue, dueDate: 1220301220), Item(title: "TODO LIST2", description: "TODO LIST for project. please help me!!", progressStatus: ProgressStatus.todo.rawValue, dueDate: 1220301220), Item(title: "TODO LIST3", description: "TODO LIST for project. please help me!!", progressStatus: ProgressStatus.todo.rawValue, dueDate: 1220301220)]),Board(title: "DOING", items: [Item(title: "TODO LIST", description: "TODO LIST for project. please help me!!", progressStatus: ProgressStatus.todo.rawValue, dueDate: 1220301220), Item(title: "DOING LIST2", description: "TODO LIST for project. please help me!!", progressStatus: ProgressStatus.todo.rawValue, dueDate: 1220301220), Item(title: "TODO LIST3", description: "DOING LIST for project. please help me!!", progressStatus: ProgressStatus.todo.rawValue, dueDate: 1220301220)]),Board(title: "DONE", items: [Item(title: "DONE LIST", description: "Done LIST for project. please help me!!", progressStatus: ProgressStatus.todo.rawValue, dueDate: 1220301220), Item(title: "DOING LIST2", description: "TODO LIST for project. please help me!!", progressStatus: ProgressStatus.todo.rawValue, dueDate: 1220301220), Item(title: "TODO LIST3", description: "DOING LIST for project. please help me!!", progressStatus: ProgressStatus.todo.rawValue, dueDate: 1220301220)])]
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
//        self.delegate = cell
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
extension ProjectManagerViewController {
    private func createNewTodoItem() {
        var newItem = boards[0].createItem("", "", dueDate: Int(Date().timeIntervalSince1970))
        let presentedSheetViewController = presentSheetViewController(with: newItem)
        
        presentedSheetViewController.updateItemHandler { (currentItem) in
            newItem = currentItem
            self.delegate = self.sectionCollectionView.cellForItem(at: [0,0]) as? SectionCollectionViewCell
            self.delegate?.addNewCell(newItem)
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
