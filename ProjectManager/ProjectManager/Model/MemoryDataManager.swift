import Foundation

class MemoryDataManager: DataManager {
    private var storage: [Work] = []
    
    var todoList: [Work] {
        storage.filter { work in
            work.sort == .todo
        }
    }
    var doingList: [Work] {
        storage.filter { work in
            work.sort == .doing
        }
    }
    var doneList: [Work] {
        storage.filter { work in
            work.sort == .done
        }
    }
    
    func create(_ data: Work) {
        storage.append(data)
    }
    
    func delete(_ data: Work) throws {
        guard let index = storage.firstIndex(where: { $0.id == data.id }) else { return }
        storage.remove(at: index)
    }
    
    func update(_ data: Work, title: String?, body: String?, date: Date?) {
        guard let index = storage.firstIndex(where: { $0.id == data.id }) else { return }
        storage[index].title = title
        storage[index].body = body
        storage[index].date = date
    }
}
