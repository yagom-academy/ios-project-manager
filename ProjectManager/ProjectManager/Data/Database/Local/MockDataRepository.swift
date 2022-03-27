import Foundation
import RxSwift
import RxRelay

final class MemoryDataBase: DataRepository {
    
    var storage = BehaviorRelay<[Listable]>(value: [])
    
    func create(object: Listable) {
        var lists = [Listable]()
        lists = self.storage.value
        lists.append(object)
        self.storage.accept(lists)
    }
    
    func read(identifier: String) -> Listable? {
        let lists = self.storage.value
        let filteredLists = lists.filter { $0.identifier == identifier }
        return filteredLists.first
    }
    
    func update(identifier: String, how object: Listable) {
        var lists = self.storage.value
        var indexToUpdate: Int = .zero
        
        lists.enumerated().forEach { index, lists in
            indexToUpdate = lists.identifier == identifier ? index : .zero
        }
        lists[indexToUpdate] = object
        storage.accept(lists)
    }
    
    func delete(identifier: String) {
        let lists = self.storage.value
        let deletedLists = lists.filter { $0.identifier != identifier }
        self.storage.accept(deletedLists)
    }
}
    
private extension MemoryDataBase {
    
    private func extractMockList() -> Listable? {
        let uuid = UUID().uuidString
        
        guard let projectMock = Project(name: "프로젝트", detail: "실험데이터", deadline: Date(), indentifier: uuid, progressState: ProgressState.todo.description) as? Listable
        else {
            return nil
        }
        
        return projectMock
    }
}


