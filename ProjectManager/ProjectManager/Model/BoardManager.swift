import Foundation

class BoardManager {
    static let shared = BoardManager()
    
    let todoBoard = Board(title: ProgressStatus.todo.rawValue)
    let doingBoard = Board(title: ProgressStatus.doing.rawValue)
    let doneBoard = Board(title: ProgressStatus.done.rawValue)
    lazy var boards: [Board] = {
        return [todoBoard, doingBoard, doneBoard]
    }()
    
    private let fileManager = FileManager.default
    private lazy var documentsURL: URL = {
        return fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }()
    private lazy var fileURL: URL = {
       return documentsURL.appendingPathComponent("JSONFile.json")
    }()
    private var items: [Item] = []
    
    private init() {
        let decodedData: DecodeJSON = DecodeJSON()
        
        guard fileManager.fileExists(atPath: fileURL.path) else {
            fileManager.createFile(atPath: fileURL.path, contents: nil, attributes: nil)
            return
        }
        
        do {
            let savedData = try Data(contentsOf: fileURL)
            if let savedItem = decodedData.decodeJSONFile(data: savedData, type: [Item].self) {
                items = savedItem
            }
            
            for index in 0..<items.count {
                arrangeJSONItem(item: items[index])
            }
        } catch {
            print("데이터 로딩 실패")
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
    
    func addToFile(with item: Item) {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        let encodedData = try! jsonEncoder.encode(item)
        
        do {
            if let fileUpdater = try? FileHandle(forUpdating: fileURL) {
                try fileUpdater.seek(toOffset: fileUpdater.seekToEndOfFile()-2)
                fileUpdater.write(Data("\n".utf8) + encodedData + Data(",\n]".utf8))
                fileUpdater.closeFile()
            }
        } catch {
            print("데이터 업데이트 실패")
        }
    }
}

let boardManager = BoardManager.shared
