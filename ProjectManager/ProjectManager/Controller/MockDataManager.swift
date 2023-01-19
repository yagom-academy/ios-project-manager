//
//  MockDataManager.swift
//  ProjectManager
//
//  Created by 애쉬 on 2023/01/19.
//

final class MockDataManager {
    static let shared: MockDataManager = MockDataManager()
    
    private init() {}
    
    private(set) var mockModels: [TodoModel] = [TodoModel(title: "todo test1",
                                                     body: "todo test1",
                                                     status: .todo,
                                                     date: 1673967757.6580071),
                                           TodoModel(title: "todo test1",
                                                     body: "todo test1\ntodo test1\ntodo test1\ntodo test1",
                                                     status: .todo,
                                                     date: 1673968167.6580071),
                                           TodoModel(title: "doing test1",
                                                     body: "doing test1",
                                                     status: .doing,
                                                     date: 1673967977.6580071),
                                           TodoModel(title: "done test1",
                                                     body: "done test1",
                                                     status: .done,
                                                     date: 1673967754.6580071),
                                           TodoModel(title: "done test1",
                                                     body: "done test1",
                                                     status: .done,
                                                     date: 1673968037.6580071)]
    
    func createNewTodo(item: TodoModel) {
        mockModels.append(item)
    }
    
    func updateTodo(item: TodoModel) {
        guard let previousItem = MockDataManager.shared.mockModels.filter({ $0.id == item.id }).first,
              let index = MockDataManager.shared.mockModels.firstIndex(of: previousItem) else { return }
        
        mockModels[index] = item
    }
    
    func removeTodo(item: TodoModel) {
        guard let item = MockDataManager.shared.mockModels.filter({ $0.id == item.id }).first,
              let index = MockDataManager.shared.mockModels.firstIndex(of: item) else { return }
        
        mockModels.remove(at: index)
    }
}
