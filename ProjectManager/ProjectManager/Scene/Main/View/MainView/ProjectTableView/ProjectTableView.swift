//
//  ProjectTableView.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/13.
//

import UIKit

class ProjectTableView: UITableView {
    
    // MARK: - Properties
    
    private let mockToDoItemManger: MainViewModel
    
    private let projectType: ProjectType
    
    private var projectHeaderView: ProjectTableHeaderView
    
    // MARK: Initializers
    
    init(for projectType: ProjectType, with manager: MainViewModel) {
        self.projectType = projectType
        projectHeaderView = ProjectTableHeaderView(with: projectType)
        mockToDoItemManger = manager
        super.init(frame: .zero, style: .plain)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        projectType = .todo
        projectHeaderView = ProjectTableHeaderView(with: .todo)
        mockToDoItemManger = MainViewModel()
        super.init(coder: coder)
    }
    
    private func commonInit() {
        tableHeaderView = projectHeaderView
        backgroundColor = .systemGray5
        register(ProjectTableViewCell.self, forCellReuseIdentifier: ProjectTableViewCell.identifier)
        layoutIfNeeded()
        setupIndexLabel()
    }
    
    // MARK: - Functions
    
    func getTitle() -> String {
        return projectType.titleLabel
    }
    
    func setupIndexLabel() {
        switch projectType {
        case .todo:
            projectHeaderView.setupIndexLabel(with: mockToDoItemManger.count(of: .todo))
        case .doing:
            projectHeaderView.setupIndexLabel(with: mockToDoItemManger.count(of: .doing))
        case .done:
            projectHeaderView.setupIndexLabel(with: mockToDoItemManger.count(of: .done))
        }
    }
}
