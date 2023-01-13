//
//  ListView.swift
//  ProjectManager
//
//  Created by 맹선아 on 2023/01/13.
//

import UIKit

class ListView: UIView {
    let headView = UIView(backgroundColor: .systemGroupedBackground)
    let titleLabel = UILabel(font: .title1, textAlignment: .center)
    let separatorLine = UIView(backgroundColor: .systemGray3)
    let headStack = UIStackView(axis: .vertical, alignment: .leading)
    let headAndListStack = UIStackView(axis: .vertical,
                                       spacing: 10,
                                       backgroundColor: .systemGroupedBackground)
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ProjectCell.self, forCellReuseIdentifier: ProjectCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    init(title: String) {
        super.init(frame: .zero)
        configureHierarchy()
        configureLayout()
        titleLabel.text = title
    }
    
    func configureHierarchy() {
        headView.addSubview(titleLabel)
        
        headStack.addArrangedSubview(headView)
        headStack.addArrangedSubview(separatorLine)
        
        headAndListStack.addArrangedSubview(headStack)
        headAndListStack.addArrangedSubview(tableView)
        
        addSubview(headAndListStack)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            headView.widthAnchor.constraint(equalTo: widthAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: headView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: headView.centerYAnchor),
            titleLabel.heightAnchor.constraint(equalTo: headView.heightAnchor),
            
            headStack.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1),
            
            separatorLine.heightAnchor.constraint(equalToConstant: 2),
            separatorLine.widthAnchor.constraint(equalTo: headStack.widthAnchor),
            
            headAndListStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            headAndListStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            headAndListStack.topAnchor.constraint(equalTo: topAnchor),
            headAndListStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
