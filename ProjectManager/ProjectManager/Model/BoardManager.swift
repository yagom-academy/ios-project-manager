import Foundation

class BoardManager {
    static let shared = BoardManager()
    
    let todoBoard = Board(title: ProgressStatus.todo.rawValue)
    let doingBoard = Board(title: ProgressStatus.doing.rawValue)
    let doneBoard = Board(title: ProgressStatus.done.rawValue)
    lazy var boards: [Board] = {
        return [todoBoard, doingBoard, doneBoard]
    }()
    
    private var items: [Item] = []
    
    private init() {
        items = projectFileManager.setItems()
        
        for index in 0..<items.count {
            arrangeJSONItem(item: items[index])
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
