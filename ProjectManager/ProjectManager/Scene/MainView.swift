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
    
    private let tableStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    // MARK: UIComponents - TableViewHeader
    
    private let todoHeaderView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 100))
        view.backgroundColor = .systemGray6
        
        let title = UILabel(frame: view.bounds)
        title.text = "TODO"
        title.font = .preferredFont(forTextStyle: .title2)
        
        view.addSubview(title)
        return view
    }()
    
    private let doingHeaderView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 100))
        view.backgroundColor = .systemGray6
        
        let title = UILabel(frame: view.bounds)
        title.text = "DOING"
        title.font = .preferredFont(forTextStyle: .title2)
        
        view.addSubview(title)
        return view
    }()
    
    private let doneHeaderView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 100))
        view.backgroundColor = .systemGray6
        
        let title = UILabel(frame: view.bounds)
        title.text = "DONE"
        title.font = .preferredFont(forTextStyle: .title2)
        
        view.addSubview(title)
        return view
    }()

    // MARK: UIComponents - TableView
    
    let todoTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let doingTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let doneTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: setUp
    
    private func setUp() {
        setUpSubView()
        setTableViewHeader()
        setConstraint()
    }
    
    private func setUpSubView() {
        backgroundColor = .white
        addSubview(tableStackView)
        tableStackView.addSubViews(todoTableView, doingTableView, doneTableView)
    }
    
    private func setConstraint() {
        NSLayoutConstraint.activate([
            tableStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            tableStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            tableStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            todoTableView.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.3),
            doingTableView.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.3),
            doneTableView.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.3)
        ])
    }
    
    private func setTableViewHeader() {
        todoTableView.tableHeaderView = todoHeaderView
        doingTableView.tableHeaderView = doingHeaderView
        doneTableView.tableHeaderView = doneHeaderView
    }
}
