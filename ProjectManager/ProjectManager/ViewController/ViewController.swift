import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var titleNavigationBar: UINavigationBar!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var sectionCollectionView: UICollectionView!
    
    private let todoBoard = UITableView()
    private let doingBoard = UITableView()
    private let doneBoard = UITableView()
    private lazy var boards: [UITableView] = {
        return [todoBoard, doingBoard, doneBoard]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleNavigationBar.topItem?.title = "Project Manager"
    }
    
    @IBAction func tappedAddButton(_ sender: Any) {
        presentSheetViewController()
    }
}
extension ViewController: UICollectionViewDelegate {
    
}
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return boards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SectionCollectionViewCell.identifier , for: indexPath) as? SectionCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.delegate = self
        return cell
    }
}
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionViewCellWidth = collectionView.frame.width / 3.08
        let collectionViewCellHeight = collectionView.frame.height
        
        return CGSize(width: collectionViewCellWidth, height: collectionViewCellHeight)
    }
}
extension ViewController: BoardTableViewCellDelegate {
    func tableViewCell(_ boardTableViewCell: BoardTableViewCell, didSelectAt index: Int, tappedCollectionViewCell: SectionCollectionViewCell) {
        presentSheetViewController()
    }
}
extension ViewController {
    private func presentSheetViewController() {
        guard let sheetViewController = self.storyboard?.instantiateViewController(identifier: SheetViewController.identifier) else {
            return
        }
        
        sheetViewController.modalPresentationStyle = .formSheet
        self.present(sheetViewController, animated: true, completion: nil)
    }
}
