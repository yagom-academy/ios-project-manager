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
        let decodedData: DecodeJSON = DecodeJSON()
        
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent("JSONFile.json")
        
        let savedData = try! Data(contentsOf: fileURL)
        if let savedItem = decodedData.decodeJSONFile(data: savedData, type: [Item].self) {
            items = savedItem
        }
        
        for index in 0..<items.count {
            addJSONItem(item: items[index])
        }
    }
    
    func addJSONItem(item: Item) {
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
