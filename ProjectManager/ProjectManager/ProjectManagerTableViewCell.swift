//
//  ProjectManagerTableViewCell.swift
//  ProjectManager
//
//  Created by kio on 2021/07/01.
//

import UIKit

class ProjectManagerTableViewCell: UITableViewCell {
       
    static let identifier = "ProjectManagerTableViewCell"
    let projectManagerCellStackView = ProjectManagerCellStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: ProjectManagerTableViewCell.identifier)
        configureCellStackView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configureCellStackView() {
        addSubview(projectManagerCellStackView)
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            projectManagerCellStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            projectManagerCellStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            projectManagerCellStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            projectManagerCellStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

