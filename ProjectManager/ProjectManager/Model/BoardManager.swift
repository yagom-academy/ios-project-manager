import UIKit

final class BoardManager {
    static let shared = BoardManager()
    var boards = [UITableView]()
    
    private init() {}
}
let boardManager = BoardManager.shared
