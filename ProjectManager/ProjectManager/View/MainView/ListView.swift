//
//  ListView.swift
//  ProjectManager
//
//  Created by 써니쿠키 on 2023/01/13.
//

import UIKit

final class ListView: UIView {
    
    private let headView = UIView(backgroundColor: .systemGroupedBackground)
    private let titleLabel = UILabel(font: .title1, textAlignment: .center)
    private let countLabel = CircleLabel(text: "0")
    private let separatorLine = UIView(backgroundColor: .systemGray3)
    private let headStack = UIStackView(axis: .vertical, alignment: .leading)
    private let headAndListStack = UIStackView(axis: .vertical,
                                               spacing: 5,
                                               backgroundColor: .systemGroupedBackground)
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(ListCell.self, forCellReuseIdentifier: ListCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    var projectList: UITableView {
        return tableView
    }
    
    init() {
        super.init(frame: .zero)
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupListTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func setupCountText(_ count: String) {
        countLabel.text = count
    }
    
    func setupProjectList(delegator: UITableViewDelegate, color: UIColor) {
        tableView.delegate = delegator
        tableView.backgroundColor = color
    }
}

// MARK: - Layout
extension ListView {
    
    private func configureHierarchy() {
        headView.addSubview(titleLabel)
        headView.addSubview(countLabel)
        
        headStack.addArrangedSubview(headView)
        headStack.addArrangedSubview(separatorLine)
        
        headAndListStack.addArrangedSubview(headStack)
        headAndListStack.addArrangedSubview(tableView)
        
        addSubview(headAndListStack)
    }
    
    private func configureLayout() {
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
}
