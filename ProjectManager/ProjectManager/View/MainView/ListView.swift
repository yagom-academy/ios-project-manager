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
    let countLabel = CircleLabel(text: "0")
    let separatorLine = UIView(backgroundColor: .systemGray3)
    let headStack = UIStackView(axis: .vertical, alignment: .leading)
    let headAndListStack = UIStackView(axis: .vertical,
                                       spacing: 5,
                                       backgroundColor: .systemGroupedBackground)
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(ListCell.self, forCellReuseIdentifier: ListCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    init() {
        super.init(frame: .zero)
        configureHierarchy()
        configureLayout()
    }
    
    func configureHierarchy() {
        headView.addSubview(titleLabel)
        headView.addSubview(countLabel)
        
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
            
            countLabel.trailingAnchor.constraint(equalTo: headView.trailingAnchor, constant: -40),
            countLabel.centerYAnchor.constraint(equalTo: headView.centerYAnchor),
            countLabel.widthAnchor.constraint(greaterThanOrEqualTo: countLabel.heightAnchor),
            
            headStack.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1),
            
            separatorLine.heightAnchor.constraint(equalToConstant: 1),
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
