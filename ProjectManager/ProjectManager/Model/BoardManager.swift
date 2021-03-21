import Foundation

enum HistoryLog {
    case add(String)
    case move(String, String, String)
    case delete(String)
    
    var description: String {
        switch self {
        case .add(let title):
            return "Added \(title)"
        case .move(let title, let before,  let after):
            return "Moved \(title) from \(before) to \(after)"
        case .delete(let title):
            return "Deleted \(title)"
        }
    }
}

class BoardManager {
    static let shared = BoardManager()
    
    let todoBoard = Board(title: ProgressStatus.todo.rawValue)
    let doingBoard = Board(title: ProgressStatus.doing.rawValue)
    let doneBoard = Board(title: ProgressStatus.done.rawValue)
    lazy var boards: [Board] = {
        return [todoBoard, doingBoard, doneBoard]
    }()
    
    var historyContainer = [(String, Date)]()
    
    private var items: [Item] = []
    
    private init() {
        items = projectFileManager.setItems()
        
        for item in items {
            arrangeJSONItem(item: item)
        }
    }
    
    private func arrangeJSONItem(item: Item) {
        switch item.progressStatus {
        case ProgressStatus.todo.rawValue:
            todoBoard.addItem(Item(title: item.title, description: item.description, progressStatus: item.progressStatus, timeStamp: item.timeStamp))
        case ProgressStatus.doing.rawValue:
            doingBoard.addItem(Item(title: item.title, description: item.description, progressStatus: item.progressStatus, timeStamp: item.timeStamp))
        case ProgressStatus.done.rawValue:
            doneBoard.addItem(Item(title: item.title, description: item.description, progressStatus: item.progressStatus, timeStamp: item.timeStamp))
        default:
            break
        }
    }
}

let boardManager = BoardManager.shared
