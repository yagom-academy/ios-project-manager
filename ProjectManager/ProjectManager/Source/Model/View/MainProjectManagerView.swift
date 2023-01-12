//
//  MainProjectManagerView.swift
//  ProjectManager
//
//  Created by Dragon on 2023/01/12.
//

import UIKit

final class MainProjectManagerView: UIView {
    
    // MARK: Properties
    
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
        tableView.register(MainLeftTableViewCell.self, forCellReuseIdentifier: MainLeftTableViewCell.identifier)
        
        return tableView
    }()
    private let centerTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MainLeftTableViewCell.self, forCellReuseIdentifier: MainLeftTableViewCell.identifier)
        
        return tableView
    }()
    
    private let rightTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MainLeftTableViewCell.self, forCellReuseIdentifier: MainLeftTableViewCell.identifier)
        
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
        addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
