//
//  MainProjectManagerView.swift
//  ProjectManager
//
//  Created by Dragon on 2023/01/12.
//

import UIKit

final class MainProjectManagerView: UIView {
    
    // MARK: Properties
    
    private let titleView: UIView = {
        let view = MainTitleView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        return view
    }()
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }()
    let leftTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray5
        tableView.register(
            MainLeftTableViewCell.self,
            forCellReuseIdentifier: MainLeftTableViewCell.identifier
        )
        return tableView
    }()
    let centerTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray5
        tableView.register(
            MainLeftTableViewCell.self,
            forCellReuseIdentifier: MainLeftTableViewCell.identifier
        )
        return tableView
    }()
    let rightTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray5
        tableView.register(
            MainLeftTableViewCell.self,
            forCellReuseIdentifier: MainLeftTableViewCell.identifier
        )
        return tableView
    }()
    
    // MARK: Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpStackView()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Internal Methods
    
    func setUpTableView(with mainViewController: MainViewController) {
        leftTableView.delegate = mainViewController
        leftTableView.dataSource = mainViewController
        
        centerTableView.delegate = mainViewController
        centerTableView.dataSource = mainViewController
        
        rightTableView.delegate = mainViewController
        rightTableView.dataSource = mainViewController
    }
    
    // MARK: Private Methods
    
    private func setUpStackView() {
        mainStackView.addArrangedSubview(leftTableView)
        mainStackView.addArrangedSubview(centerTableView)
        mainStackView.addArrangedSubview(rightTableView)
    }
    
    private func configureLayout() {
        addSubview(titleView)
        addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleView.topAnchor.constraint(equalTo: topAnchor),
            titleView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.08),
            
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStackView.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
