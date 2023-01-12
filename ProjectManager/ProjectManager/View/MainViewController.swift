//
//  ProjectManager - MainViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class MainViewController: UIViewController {
    typealias DataSource = UITableViewDiffableDataSource<Process, Todo>
    
    private enum Constant {
        static let navigationTitle = "Project Manager"
        static let tableSpacing = 10.0
        static let bottomValue = -50.0
    }
    
    private let todoView = ProcessStackView(process: .todo)
    private let doingView = ProcessStackView(process: .doing)
    private let doneView = ProcessStackView(process: .done)
    
    private lazy var todoDataSource = configureTodoDataSource()
    private lazy var doingDataSource = configureDoingDataSource()
    private lazy var doneDataSource = configureDoneDataSource()
    
    private lazy var mainStackView = UIStackView(
        views: [todoView, doingView, doneView],
        axis: .horizontal,
        alignment: .fill,
        distribution: .fillEqually,
        spacing: Constant.tableSpacing
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupView()
        setupConstraint()
    }
    
    @objc private func addButtonTapped() {
        // 추후 구현
    }
}

// MARK: - UI Configuration
extension MainViewController {
    private func setupNavigationBar() {
        title = Constant.navigationTitle
        let appearence = UINavigationBarAppearance()
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = .systemGray6
        navigationController?.navigationBar.standardAppearance = appearence
        navigationController?.navigationBar.scrollEdgeAppearance = appearence
        
        let addBarButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonTapped)
        )
        navigationItem.rightBarButtonItem = addBarButton
    }
    
    private func setupView() {
        view.backgroundColor = .systemGray6
        view.addSubview(mainStackView)
    }
    
    private func setupConstraint() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            mainStackView.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor,
                constant: Constant.bottomValue
            )
        ])
    }
}

// MARK: - DataSource Configuration
extension MainViewController {
    private func configureTodoDataSource() -> DataSource {
        let dataSource = DataSource(
            tableView: todoView.tableView
        ) { tableView, indexPath, todoData in

            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ProcessTableViewCell.identifier,
                for: indexPath
            ) as? ProcessTableViewCell else {
                // Error Alert 구현예정
                let errorCell = UITableViewCell()
                return errorCell
            }
            
            cell.titleLabel.text = todoData.title
            cell.descriptionLabel.text = todoData.content
            cell.dateLabel.text = todoData.convertDeadline
            return cell
        }
        return dataSource
    }

    private func configureDoingDataSource() -> DataSource {
        let dataSource = DataSource(
            tableView: doingView.tableView
        ) { tableView, indexPath, todoData in

            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ProcessTableViewCell.identifier,
                for: indexPath
            ) as? ProcessTableViewCell else {
                // Error Alert 구현예정
                let errorCell = UITableViewCell()
                return errorCell
            }
            
            cell.titleLabel.text = todoData.title
            cell.descriptionLabel.text = todoData.content
            cell.dateLabel.text = todoData.convertDeadline
            return cell
        }
        return dataSource
    }

    private func configureDoneDataSource() -> DataSource {
        let dataSource = DataSource(
            tableView: doneView.tableView
        ) { tableView, indexPath, todoData in
            
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ProcessTableViewCell.identifier,
                for: indexPath
            ) as? ProcessTableViewCell else {
                // Error Alert 구현예정
                let errorCell = UITableViewCell()
                return errorCell
            }
            
            cell.titleLabel.text = todoData.title
            cell.descriptionLabel.text = todoData.content
            cell.dateLabel.text = todoData.convertDeadline
            return cell
        }
        return dataSource
    }
}
