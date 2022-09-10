//
//  DoneListTableViewController.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/07.
//

import UIKit

final class DoneListTableViewController: UIViewController {
    
    // MARK: - Properties
    
    private let mockToDoItemManger = MockToDoItemManager()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 2
        
        return stackView
    }()
    
    private let horizontalView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let uiLabel = UILabel()
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        uiLabel.text = "DONE"
        uiLabel.font = .preferredFont(forTextStyle: .title1)
        
        return uiLabel
    }()
    
    private let indexLabel: UILabel = {
        let uiLabel = UILabel()
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        uiLabel.text = "0"
        uiLabel.textAlignment = .center
        uiLabel.textColor = .white
        uiLabel.font = .preferredFont(forTextStyle: .title3)
        uiLabel.backgroundColor = .black
        
        return uiLabel
    }()
    
    private let todoItemTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(DoneListTableViewCell.self, forCellReuseIdentifier: DoneListTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGray5
        
        return tableView
    }()
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupListTableViewLayout()
        setupDelegates()
        indexLabel.layoutIfNeeded()
        indexLabel.drawCircle()
        mockToDoItemManger.loadData()
        updateIndexLabelData()
    }
    
    // MARK: - Functions

    private func setupSubviews() {
        view.addSubview(verticalStackView)
        
        [titleLabel, indexLabel]
            .forEach { horizontalView.addSubview($0) }
        
        [horizontalView, todoItemTableView]
            .forEach { verticalStackView.addArrangedSubview($0) }
    }
    
    private func setupListTableViewLayout() {
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: view.topAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: horizontalView.topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: horizontalView.bottomAnchor, constant: -8),
            titleLabel.leadingAnchor.constraint(equalTo: horizontalView.leadingAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            indexLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            indexLabel.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            indexLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
            indexLabel.widthAnchor.constraint(equalTo: indexLabel.heightAnchor)
        ])
    }
    
    private func setupDelegates() {
        todoItemTableView.delegate = self
        todoItemTableView.dataSource = self
    }
    
    private func updateIndexLabelData() {
        indexLabel.text = mockToDoItemManger.count().description
    }
}

// MARK: - Extentions

extension DoneListTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return mockToDoItemManger.count()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DoneListTableViewCell.identifier, for: indexPath) as? DoneListTableViewCell
        else { return UITableViewCell() }
              
        cell.configure(data: mockToDoItemManger.content(index: indexPath.row) ?? ToDoItem() )
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let doneListDetailViewController = DoneListDetailViewController()
        let navigationController = UINavigationController(rootViewController: doneListDetailViewController)
        
        doneListDetailViewController.modalPresentationStyle = .formSheet
        
        present(navigationController, animated: true)
        doneListDetailViewController.loadData(of: mockToDoItemManger.content(index: indexPath.row) ?? ToDoItem())
    }
}
