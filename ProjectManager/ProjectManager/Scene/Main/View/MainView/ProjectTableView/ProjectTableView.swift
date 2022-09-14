//
//  ProjectTableView.swift
//  ProjectManager
//
//  Created by 김동용 on 2022/09/13.
//

import UIKit

class ProjectTableView: UITableView {
    
    // MARK: - Properties
    
    private let mockToDoItemManger: MockToDoItemManager
    
    private let projectType: ProjectType
    
    private var projectHeaderView: ProjectTableHeaderView
    
    // MARK: Initializers
    
    init(for projectType: ProjectType, with manager: MockToDoItemManager) {
        self.projectType = projectType // 해당 타입 설정
        projectHeaderView = ProjectTableHeaderView(with: projectType) // 헤더뷰 설정
        mockToDoItemManger = manager // 매니저 주입
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
        register(ProjectTableViewCell.self, forCellReuseIdentifier: ProjectTableViewCell.identifier) // 셀 등록
        mockToDoItemManger.loadData() // data 가져오기
        layoutIfNeeded()  // 데이터 가져온 것으로 뷰 다시 그리기
        projectHeaderView.setupIndexLabel(with: mockToDoItemManger.count()) // indexLabel 숫자 설정
    }
}
