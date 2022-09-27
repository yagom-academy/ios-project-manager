//
//  TodoProvider.swift
//  ProjectManager
//
//  Created by bonf on 2022/09/21.
//

import RxSwift

final class TodoProvider {
    static let shared = TodoProvider()
    
    // MARK: - properties

    var testProjects: [Project]
    
    private let disposeBag = DisposeBag()
    
    // MARK: - initializer

    init() {
        testProjects = Project.generateSampleData(count: 10,
                                                  maxBodyLine: 10,
                                                  startDate: "2022-09-01",
                                                  endData: "2022-09-30")
    }
    
    // MARK: - functions

    func saveData(project: Project) {
        testProjects.append(project)
    }
    
    func updateData(project: Project) {
        guard let index = testProjects.firstIndex(where: {$0.uuid == project.uuid}) else { return }
        self.testProjects.remove(at: index)
        testProjects.insert(project, at: index)
    }
}
