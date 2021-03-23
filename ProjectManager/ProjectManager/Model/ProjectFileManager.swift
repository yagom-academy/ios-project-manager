import Foundation

class ProjectFileManager {
    static let shared = ProjectFileManager()
    
    let decoder: DecodeJSON = DecodeJSON()
    private let fileManager = FileManager.default
    private lazy var documentsURL: URL = {
        return fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }()
    
    private lazy var fileURL: URL = {
        return documentsURL.appendingPathComponent("JSONFile.json")
    }()
    
    private var allItems: [Item] {
        return boardManager.todoBoard.items + boardManager.doingBoard.items + boardManager.doneBoard.items
    }
    
    private init() {
        guard fileManager.fileExists(atPath: fileURL.path) else {
            fileManager.createFile(atPath: fileURL.path, contents: nil, attributes: nil)
            return
        }
    }
    
    func setItems() -> [Item] {
        do {
            let savedData = try Data(contentsOf: fileURL)
            if let savedItems = decoder.decodeJSONFile(data: savedData, type: [Item].self) {
                return savedItems
            }
        } catch {
            print("데이터 로딩 실패")
        }
        return []
    }
    
    func updateFile() {
        let data = try! JSONEncoder().encode(allItems)
        try? data.write(to: fileURL)
    }
}

let projectFileManager = ProjectFileManager.shared
