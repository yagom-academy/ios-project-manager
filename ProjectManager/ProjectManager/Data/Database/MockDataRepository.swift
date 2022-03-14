import Foundation
import RxSwift

class MockDataRepository: DataRepository {
    
    private var dataBase = PublishSubject<Listable>()
    
    func create(attributes: [String: Any]) {
        let uuid = UUID().uuidString
        guard let projectMock = Project(name: "프로젝트", detail: "실험데이터", deadline: Date(), indentifier: uuid, progressState: ProgressState.todo.description) as? Listable
        else {
            return
        }
        dataBase.onNext(projectMock)
    }
    
    func read(identifier: String) -> Listable? {
       
        return nil
    }
    
    
    func update(identifier: String, how attributes: [String : Any]) {
        
    }
    
    func delete(identifier: String) {
        
    }
    
    func fetch() {
        
    }

    func extractAll() -> [Listable] {
       return []
    }
}

