//
//  MainView.swift
//  ProjectManager
//
//  Created by 우롱차, 파프리 on 06/07/2022.
//

import UIKit

final class MainView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UIComponents - StackView
    
    private var tableStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.axis = .horizontal
        return stackView
    }()
    
    // MARK: UIComponents - TableView
    
    private var todoTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var doingTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var doneTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: setUp
    
    private func setUp() {
        backgroundColor = .white
        addSubview(tableStackView)
        tableStackView.addSubViews(todoTableView, doingTableView, doneTableView)
        
        NSLayoutConstraint.activate([
            tableStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            tableStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            tableStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}
