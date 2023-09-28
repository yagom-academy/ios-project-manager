//
//  ProjectTableViewCellViewModel.swift
//  ProjectManager
//
//  Created by Erick on 2023/09/28.
//

import UIKit

protocol ProjectTableViewCellViewModel {
    var title: String { get }
    var body: String { get }
    var deadline: String { get }
    var deadlineColor: UIColor { get }
}

final class DefaultProjectTableViewCellViewModel: ProjectTableViewCellViewModel {
    
    // MARK: - Private Property
    private var project: Project
    
    // MARK: - Life Cycle
    init(project: Project) {
        self.project = project
    }
    
    // MARK: - OUTPUT
    var title: String { project.title }
    var body: String { project.body }
    var deadline: String { CurrentDateFormatManager.shared.string(from: project.deadline) }
    var deadlineColor: UIColor { Calendar.compareDate(project.deadline, with: Date()) ? .red : .label }
}
