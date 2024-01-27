//
//  ListViewController.swift
//  ProjectManager
//
//  Created by Toy on 1/24/24.
//

import UIKit

final class ListViewController: UIViewController {
    // MARK: - Property
    private let scheduleType: Schedule
    
    private let tableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray6
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var headerView = {
        let view = HeaderView(frame: .zero, schedule: scheduleType)
        view.backgroundColor = .systemGray6
        return view
    }()
    
    private let stackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        setupTableView()
        setupStackView()
        setupStackViewConstraint()
    }
    
    // MARK: - Helper
    init(scheduleType: Schedule) {
        self.scheduleType = scheduleType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
    }
    
    private func setupStackView() {
        stackView.addArrangedSubview(headerView)
        stackView.addArrangedSubview(tableView)
        view.addSubview(stackView)
    }
    
    private func setupStackViewConstraint() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
    }
    
}

// MARK: - UITableViewDataSource Method
extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate Method
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
