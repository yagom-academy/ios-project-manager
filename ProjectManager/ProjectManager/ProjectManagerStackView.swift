//
//  ProjectManagerStackView.swift
//  ProjectManager
//
//  Created by kio on 2021/07/01.
//

import UIKit

class ProjectManagerStackView: UIStackView {

    let toDoTableView = UITableView()
    let doingTableView = UITableView()
    let doneTableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureProjectManagerStackView()
        configureProjectManagerTableView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureProjectManagerStackView() {
        axis = .horizontal
        alignment = .fill
        distribution = .fillEqually
        spacing = 10
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureProjectManagerTableView() {
        addArrangedSubview(toDoTableView)
        addArrangedSubview(doingTableView)
        addArrangedSubview(doneTableView)
        
//        toDoTableView.tableFooterView = UIView(frame: .zero)
//        doingTableView.tableFooterView = UIView(frame: .zero)
//        doneTableView.tableFooterView = UIView(frame: .zero)
        
        toDoTableView.register(ProjectManagerTableViewCell.self, forCellReuseIdentifier: ProjectManagerTableViewCell.identifier)
        doingTableView.register(ProjectManagerTableViewCell.self, forCellReuseIdentifier: ProjectManagerTableViewCell.identifier)
        doneTableView.register(ProjectManagerTableViewCell.self, forCellReuseIdentifier: ProjectManagerTableViewCell.identifier)
    }
}
