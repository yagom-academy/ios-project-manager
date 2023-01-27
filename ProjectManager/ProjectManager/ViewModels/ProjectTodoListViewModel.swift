//
//  ProjectTodoListViewModel.swift
//  ProjectManager
//
//  Created by junho lee on 2023/01/16.
//

import Foundation

final class ProjectTodoListViewModel {
    private var onUpdated: ([UUID]) -> Void = { _ in }
    private var updatedProjectTodosID: [UUID] = []
    private var databaseManager = DatabaseManager()
    private var projectTodos: [ProjectTodo] {
        didSet {
            onUpdated(updatedProjectTodosID)
            updatedProjectTodosID.removeAll()
        }
    }

    init(projectTodos: [ProjectTodo] = []) {
        self.projectTodos = projectTodos
    }

    func fetchDataFromDatabase() {
        databaseManager.fetchProjectTodos { [weak self] projectTodos in
            self?.projectTodos = projectTodos
        }
    }

    func bind(onUpdated: @escaping ([UUID]) -> Void) {
        self.onUpdated = onUpdated
    }

    func add(projectTodo: ProjectTodo) {
        projectTodos.append(projectTodo)
        databaseManager.add(projectTodo)
    }

    func update(projectTodo: ProjectTodo) {
        guard let index = projectTodos.firstIndex(where: { $0.id == projectTodo.id }) else { return }
        updatedProjectTodosID.append(projectTodo.id)
        databaseManager.update(projectTodo)
        projectTodos[index] = projectTodo
    }

    func delete(for projectTodoID: UUID) {
        projectTodos.removeAll(where: { $0.id == projectTodoID })
        databaseManager.delete(projectTodoID)
    }

    func projectTodoViewModel(for projectTodoID: UUID) -> ProjectTodoViewModel? {
        guard let projectTodo = projectTodo(for: projectTodoID) else { return nil }
        let projectTodoViewModel = ProjectTodoViewModel(projectTodo: projectTodo)
        return projectTodoViewModel
    }

    func projectTodo(for projectTodoID: UUID) -> ProjectTodo? {
        guard let projectTodo = projectTodos.first(where: { $0.id == projectTodoID }) else { return nil }
        return projectTodo
    }

    func projectTodoIDs(for stateIndex: Int) -> [UUID] {
        return projectTodos.filter { $0.state.rawValue == stateIndex }.map { $0.id }
    }

    func projectState(for index: Int) -> ProjectState? {
        guard let projectState = ProjectState(rawValue: index) else { return nil }
        return projectState
    }

    func projectTodosCount(for index: Int) -> Int {
        return projectTodos.filter { $0.state.rawValue == index }.count
    }

    func projectStateCount() -> Int {
        return ProjectState.allCases.count
    }

    func createDueDateAttributedString(_ dueDate: Date) -> NSAttributedString {
        if dueDate.isEarlierThanToday() {
            return NSAttributedString(string: dueDate.localizedDateString(),
                                      attributes: [.foregroundColor: ProjectColor.overdueDate.color])
        } else {
            return NSAttributedString(string: dueDate.localizedDateString())
        }
    }
}
