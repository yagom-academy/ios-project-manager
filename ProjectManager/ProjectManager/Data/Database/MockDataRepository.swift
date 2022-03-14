import Foundation

class MockDataRepository: DataRepository {
    private var dataBase = [Listable]()
    
    func create(attributes: [String: Any]) {
        let uuid = UUID().uuidString
        dataBase.append(Project(name: "프로젝트", detail: "실험데이터", deadline: Date(), indentifier: uuid, progressState: ProgressState.todo.description))
    }
    
    func read(identifier: String) -> Listable? {
        dataBase.filter{ $0.identifier == identifier }.first
    }
    
    func update(identifier: String, how attributes: [String : Any]) {
        
    }
    
    func delete(identifier: String) {
        
    }
    
    func fetch() {
        
    }
    
    func extractAll() -> [Listable] {
        return dataBase
    }
    
    
}
