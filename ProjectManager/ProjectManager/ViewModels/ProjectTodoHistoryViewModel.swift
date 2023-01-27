//
//  ProjectTodoHistoryViewModel.swift
//  ProjectManager
//
//  Created by junho lee on 2023/01/27.
//

import Foundation

final class ProjectTodoHistoryViewModel {
    private var projectTodoHistories = [ProjectTodoHistory]()

    func projectTodoHistory(for projectTodoHistoryID: UUID) -> ProjectTodoHistory? {
        return projectTodoHistories.first(where: { $0.id == projectTodoHistoryID })
    }

    func add(_ projectTodoHistory: ProjectTodoHistory) {
        projectTodoHistories.append(projectTodoHistory)
    }

    func peekLast(_ count: Int = 1) -> [ProjectTodoHistory] {
        guard projectTodoHistories.isEmpty == false else { return [] }
        var histories = [ProjectTodoHistory]()
        if projectTodoHistories.count >= count {
            histories.insert(contentsOf: projectTodoHistories.dropFirst(projectTodoHistories.count - count), at: 0)
        } else {
            histories = projectTodoHistories
        }
        return histories
    }

    func peekLastIDs(_ count: Int = 1) -> [UUID] {
        return peekLast(count).map { $0.id }
    }

    func localizedString(_ projectTodoHistory: ProjectTodoHistory) -> String {
        switch projectTodoHistory.action {
        case .add:
            let localizedFormat = NSLocalizedString("Added '%@'.", comment: "Added History String Format")
            return String(format: localizedFormat, projectTodoHistory.newValue?.title ?? "")
        case .move:
            let localizedFormat = NSLocalizedString("Moved '%@'from %@ to %@.", comment: "Moved History String Format")
            return String(format: localizedFormat,
                          projectTodoHistory.newValue?.title ?? "",
                          projectTodoHistory.oldValue?.state.description ?? "",
                          projectTodoHistory.newValue?.state.description ?? "")
        case .remove:
            let localizedFormat = NSLocalizedString("Removed '%@' from %@.", comment: "Removed History String Format")
            return String(format: localizedFormat,
                          projectTodoHistory.oldValue?.title ?? "",
                          projectTodoHistory.oldValue?.state.description ?? "")
        }
    }
}
