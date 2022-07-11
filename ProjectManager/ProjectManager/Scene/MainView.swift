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
    
    private let todoHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "TODO"
        label.font = .preferredFont(forTextStyle: .title2)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let doingHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "DOING"
        label.font = .preferredFont(forTextStyle: .title2)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let doneHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "DONE"
        label.font = .preferredFont(forTextStyle: .title2)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let todoHeaderCounter: CircleLabel = {
        let label = CircleLabel()
        label.text = " 112221 "
        label.font = .preferredFont(forTextStyle: .title2)
        label.backgroundColor = .black
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let doingHeaderCounter: CircleLabel = {
        let label = CircleLabel()
        label.text = " 2 "
        label.font = .preferredFont(forTextStyle: .title2)
        label.backgroundColor = .black
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let doneHeaderCounter: CircleLabel = {
        let label = CircleLabel()
        label.text = " 3 "
        label.font = .preferredFont(forTextStyle: .title2)
        label.backgroundColor = .black
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let todoHeaderView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let doingHeaderView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let doneHeaderView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: UIComponents - TableView
    
    private let todoTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGray6
        return tableView
    }()
    
    private let doingTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGray6
        return tableView
    }()
    
    private let doneTableView: UITableView = {
            let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGray6
        return tableView
    }()
    
    private let todoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()
    
    private let doingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()
    
    private let doneStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()
    
    // MARK: functions
    
    func retrieveTableView(taskCase: TaskCase) -> UITableView {
        switch taskCase {
        case .todo:
            return todoTableView
        case .doing:
            return doingTableView
        case .done:
            return doneTableView
        }
    }
    
    // MARK: setUp
    
    private func setUp() {
        backgroundColor = .white
        setUpSubView()
        setConstraint()
        setUpHeader()
    }
    
    private func setUpSubView() {
        todoStackView.addSubViews(todoHeaderView, todoTableView)
        doingStackView.addSubViews(doingHeaderView, doingTableView)
        doneStackView.addSubViews(doneHeaderView, doneTableView)
        tableStackView.addSubViews(todoStackView, doingStackView, doneStackView)
        addSubview(tableStackView)
    }
    
    private func setConstraint() {
        NSLayoutConstraint.activate([
            tableStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            tableStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            tableStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            todoStackView.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.3),
            doingStackView.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.3),
            doneStackView.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.3),
            todoTableView.widthAnchor.constraint(equalTo: todoStackView.widthAnchor),
            doingTableView.widthAnchor.constraint(equalTo: doingTableView.widthAnchor),
            doneTableView.widthAnchor.constraint(equalTo: doneTableView.widthAnchor),
            todoHeaderView.widthAnchor.constraint(equalTo: todoTableView.widthAnchor),
            doingHeaderView.widthAnchor.constraint(equalTo: doingTableView.widthAnchor),
            doneHeaderView.widthAnchor.constraint(equalTo: doneTableView.widthAnchor),
            todoHeaderView.heightAnchor.constraint(equalToConstant: 50),
            doingHeaderView.heightAnchor.constraint(equalToConstant: 50),
            doneHeaderView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setUpHeader() {
        todoHeaderView.addSubview(todoHeaderLabel)
        doingHeaderView.addSubview(doingHeaderLabel)
        doneHeaderView.addSubview(doneHeaderLabel)
        todoHeaderView.addSubview(todoHeaderCounter)
        doingHeaderView.addSubview(doingHeaderCounter)
        doneHeaderView.addSubview(doneHeaderCounter)
        
        NSLayoutConstraint.activate([
            todoHeaderLabel.leadingAnchor.constraint(equalTo: todoHeaderView.leadingAnchor),
            doingHeaderLabel.leadingAnchor.constraint(equalTo: doingHeaderView.leadingAnchor),
            doneHeaderLabel.leadingAnchor.constraint(equalTo: doneHeaderView.leadingAnchor),
            todoHeaderLabel.bottomAnchor.constraint(equalTo: todoHeaderView.bottomAnchor),
            doingHeaderLabel.bottomAnchor.constraint(equalTo: doingHeaderView.bottomAnchor),
            doneHeaderLabel.bottomAnchor.constraint(equalTo: doneHeaderView.bottomAnchor),
            todoHeaderLabel.trailingAnchor.constraint(equalTo: todoHeaderCounter.leadingAnchor),
            doingHeaderLabel.trailingAnchor.constraint(equalTo: doingHeaderCounter.leadingAnchor),
            doneHeaderLabel.trailingAnchor.constraint(equalTo: doneHeaderCounter.leadingAnchor),
            todoHeaderLabel.bottomAnchor.constraint(equalTo: todoHeaderCounter.bottomAnchor),
            doingHeaderLabel.bottomAnchor.constraint(equalTo: doingHeaderCounter.bottomAnchor),
            doneHeaderLabel.bottomAnchor.constraint(equalTo: doneHeaderCounter.bottomAnchor)
        ])
    }
}
