//
//  DefaultListUseCase.swift
//  ProjectManager
//
//  Created by GUNDY on 2023/01/17.
//

final class DefaultListUseCase: ListUseCase {

    private var list: ProjectList

    init(list: ProjectList) {
        self.list = list
    }

    func fetchProjectList(state: State) -> [Project] {
        let filteredList: [Project] = list.projects.filter {
            $0.state == state
        }

        return filteredList
    }

    func addNewProject(_ project: Project) {
        list.projects.append(project)
    }

    func editProject(_ project: Project) {
        guard let index = fetchIndex(of: project) else {
            return
        }

        list.projects[index] = project
    }

    private func fetchIndex(of project: Project) -> Int? {
        let index: Int? = list.projects.firstIndex {
            $0.identifier == project.identifier
        }

        return index
    }

    func removeProject(_ project: Project) {
        guard let index = fetchIndex(of: project) else {
            return
        }

        list.projects.remove(at: index)
    }
}
