//
//  ProjectListView.swift
//  ProjectManager
//
//  Created by Groot on 2022/09/22.
//

import UIKit

private enum Design {
    static let mainStackViewSpacing: CGFloat = 8
}

final class ProjectListView: UIView {
    // MARK: - Properties
    private let todoTableView = UITableView()
    private let doingTableView = UITableView()
    private let doneTabelView = UITableView()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = Design.mainStackViewSpacing
        stackView.backgroundColor = .systemGray5
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    var rootViewController: UIViewController?
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func retrieveTableView(with state: ProjectState) -> UITableView {
        switch state {
        case .todo:
            return todoTableView
        case .doing:
            return doingTableView
        case .done:
            return doneTabelView
        }
    }
    
    func configureTableViews() {
        [
            todoTableView,
            doingTableView,
            doneTabelView
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.backgroundColor = .systemGray6
            $0.dataSource = rootViewController as? UITableViewDataSource
            $0.delegate = rootViewController as? UITableViewDelegate
            $0.register(ProjectTableViewCell.self,
                        forCellReuseIdentifier: ProjectTableViewCell.reuseIdentifier)
            mainStackView.addArrangedSubview($0)
            
        }
    }
    
    private func commonInit() {
        configureStackViewLayout()
    }
    
    private func configureStackViewLayout() {
        addSubview(mainStackView)
        
        NSLayoutConstraint.activate(
            [
                mainStackView.topAnchor
                    .constraint(equalTo: super.safeAreaLayoutGuide.topAnchor),
                mainStackView.bottomAnchor
                    .constraint(equalTo: super.safeAreaLayoutGuide.bottomAnchor),
                mainStackView.leadingAnchor
                    .constraint(equalTo: super.safeAreaLayoutGuide.leadingAnchor),
                mainStackView.trailingAnchor
                    .constraint(equalTo: super.safeAreaLayoutGuide.trailingAnchor)
            ]
        )
    }
}
