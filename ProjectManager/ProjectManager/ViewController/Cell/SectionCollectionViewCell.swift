import UIKit
protocol AddItemDelegate: AnyObject {
    func addNewCell(with item: Item)
}

class SectionCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var boardTableView: UITableView!
    var board: Board?
    static let identifier = "SectionCollectionViewCell"
    
    override func awakeFromNib() {
        registerXib()
    }
    
    private func registerXib(){
        let nibName = UINib(nibName: BoardTableViewCell.identifier, bundle: nil)
        boardTableView.register(nibName, forCellReuseIdentifier: BoardTableViewCell.identifier)
    }
    
    func configureBoard(with board: Board) {
        self.board = board
        boardTableView.reloadData()
    }
}
extension SectionCollectionViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BoardTableViewCell.identifier) as? BoardTableViewCell else {
            return UITableViewCell()
        }
        
        guard let item = board?.items[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.updateUI(with: item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return board?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
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
        boardTableView.reloadData()
    }
}
