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
    }
}
