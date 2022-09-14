//
//  ProjectTableView.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/13.
//

import UIKit

class ProjectTableView: UITableView {
    
    // MARK: - Properties
    
    private let mockToDoItemManger: MockToDoItemManager
    
    private let projectType: ProjectType
    
    private var projectHeaderView: ProjectTableHeaderView
    
    // MARK: Initializers
    
    init(for projectType: ProjectType, with manager: MockToDoItemManager) {
        self.projectType = projectType
        projectHeaderView = ProjectTableHeaderView(with: projectType)
        mockToDoItemManger = manager
        super.init(frame: .zero, style: .plain)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        projectType = .todo
        projectHeaderView = ProjectTableHeaderView(with: .todo)
        mockToDoItemManger = MockToDoItemManager()
        super.init(coder: coder)
    }
    
        
    // MARK: - Functions
    
    func getTitle() -> String {
        return projectType.titleLabel
    }
    
    private func commonInit() {
        tableHeaderView = projectHeaderView
        backgroundColor = .systemGray5
        register(ProjectTableViewCell.self, forCellReuseIdentifier: ProjectTableViewCell.identifier)
        mockToDoItemManger.loadData()
        layoutIfNeeded()
        projectHeaderView.setupIndexLabel(with: mockToDoItemManger.count())
    }
}
