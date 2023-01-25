//
//  MockDataManager.swift
//  ProjectManager
//
//  Created by 애쉬 on 2023/01/19.
//

import Foundation

final class MockDataManager {
    static let shared: MockDataManager = MockDataManager()
    
    private init() {}
    
    private(set) var mockModels: [TodoModel] = [TodoModel(title: "책상정리",
                                                          body: "집중이 안될땐 역시나 책상정리",
                                                          status: .todo,
                                                          date: 1673967757.6580071),
                                                TodoModel(title: "일기쓰기",
                                                          body: "오늘은 밥먹었음 ㅎ",
                                                          status: .todo,
                                                          date: 1673968167.6580071),
                                                TodoModel(title: "TIL 작성하기",
                                                          body: "TIL을 작성하면\n오늘의 상큼한 마무리도 되고\n나중에 포르폴리오 용으로도 좋죠!",
                                                          status: .doing,
                                                          date: 1673967977.6580071),
                                                TodoModel(title: "프로젝트 회고 작성",
                                                          body: """
                                                                프로젝트 회고를 작성하면 내가 이번 프로젝트에서 무엇을 놓쳤는지 명확히 알 수 있어요.
                                                                프로젝트 회고를 작성하면 내가 이번 프로젝트에서 무엇을 놓쳤는지 명확히 알 수 있어요.
                                                                프로젝트 회고를 작성하면 내가 이번 프로젝트에서 무엇을 놓쳤는지 명확히 알 수 있어요.
                                                                프로젝트 회고를 작성하면 내가 이번 프로젝트에서 무엇을 놓쳤는지 명확히 알 수 있어요.
                                                                """,
                                                          status: .done,
                                                          date: 1673967754.6580071),
                                                TodoModel(title: "오늘의 할일 찾기",
                                                          body: "뭐가 있지?",
                                                          status: .done,
                                                          date: 1673968037.6580071)] {
        didSet {
            NotificationCenter.default.post(name: Notification.Name.mockModels, object: nil)
        }
    }
    
    var todoList: [TodoModel] {
        self.mockModels.filter { $0.status == .todo }
    }
    var doingList: [TodoModel] {
        self.mockModels.filter { $0.status == .doing }
    }
    var doneList: [TodoModel] {
        self.mockModels.filter { $0.status == .done }
    }
    
    func create(todo: TodoModel) {
        mockModels.append(todo)
    }
    
    func update(todo: TodoModel, status: TodoModel.TodoStatus) {
        guard var previousItem = MockDataManager.shared.mockModels.filter({ $0.id == todo.id }).first,
              let index = MockDataManager.shared.mockModels.firstIndex(of: previousItem) else { return }
        
        previousItem = todo
        previousItem.status = status
        mockModels[index] = previousItem
    }
    
    func remove(todo: TodoModel) {
        guard let item = MockDataManager.shared.mockModels.filter({ $0.id == todo.id }).first,
              let index = MockDataManager.shared.mockModels.firstIndex(of: item) else { return }
        
        mockModels.remove(at: index)
    }
}

extension Notification.Name {
    static let mockModels = Notification.Name("mockModels")
}
