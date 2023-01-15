//
//  ProjectManager - MainViewController.swift
//  Created by yagom.
//  Copyright © yagom. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {
    typealias DataSource = UITableViewDiffableDataSource<Section, Todo>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Todo>
    
    enum Section {
        case main
    }
    
    private enum UIConstant {
        static let navigationTitle = "Project Manager"
        static let tableSpacing = 10.0
        static let bottomValue = -50.0
    }
    
    private let viewModel = MainViewModel()
    private let todoView = ProcessStackView(process: .todo)
    private let doingView = ProcessStackView(process: .doing)
    private let doneView = ProcessStackView(process: .done)
    
    private lazy var todoDataSource = configureDataSource(process: .todo)
    private lazy var doingDataSource = configureDataSource(process: .doing)
    private lazy var doneDataSource = configureDataSource(process: .done)
    
    private lazy var mainStackView = UIStackView(
        views: [todoView, doingView, doneView],
        axis: .horizontal,
        alignment: .fill,
        distribution: .fillEqually,
        spacing: UIConstant.tableSpacing
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
        setupNavigationBar()
        setupView()
        setupTableView()
        setupConstraint()
    }
    
    @objc private func addButtonTapped() {
        let addViewController = AddViewController()
        addViewController.modalPresentationStyle = .formSheet
        
        let addNavigationController = UINavigationController(
            rootViewController: addViewController
        )
        present(addNavigationController, animated: true)
    }
    
    private func setupBinding() {
        viewModel.bindTodo { [weak self] data in
            self?.applySnapshot(process: .todo, data: data, animating: true)
        }
        
        viewModel.bindDoing { [weak self] data in
            self?.applySnapshot(process: .doing, data: data, animating: true)
        }
        
        viewModel.bindDone { [weak self] data in
            self?.applySnapshot(process: .done, data: data, animating: true)
        }
    }
}

// MARK: - UI, TableView Configuration
extension MainViewController {
    private func setupNavigationBar() {
        title = UIConstant.navigationTitle
        let appearance = UINavigationBarAppearance()
        
        appearance.backgroundColor = .systemGray6
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

        let addBarButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonTapped)
        )
        navigationItem.rightBarButtonItem = addBarButton
    }
    
    private func setupTableView() {
        [todoView, doingView, doneView].forEach {
            $0.tableView.delegate = self
        }
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
                constant: UIConstant.bottomValue
            )
        ])
    }
}

// MARK: - DataSource, Snapshot Configuration
extension MainViewController {
    private func configureDataSource(process: Process) -> DataSource {
        let tableView: UITableView
        switch process {
        case .todo:
            tableView = todoView.tableView
        case .doing:
            tableView = doingView.tableView
        case .done:
            tableView = doneView.tableView
        }
        
        let dataSource = DataSource(
            tableView: tableView
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
    
    private func applySnapshot(process: Process, data: [Todo], animating: Bool) {
        var snapshot = Snapshot()
        
        snapshot.appendSections([.main])
        snapshot.appendItems(data)
        
        switch process {
        case .todo:
            todoDataSource.apply(snapshot, animatingDifferences: animating)
        case .doing:
            doingDataSource.apply(snapshot, animatingDifferences: animating)
        case .done:
            doneDataSource.apply(snapshot, animatingDifferences: animating)
        }
    }
}

extension MainViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let process: Process
//
//        switch tableView {
//        case todoView.tableView:
//            process = .todo
//        case doingView.tableView:
//            process = .doing
//        case doneView.tableView:
//            process = .done
//        default:
//            return
//        }
//
//        let editViewController = EditViewController(process: process, indexPath: indexPath)
//        editViewController.modalPresentationStyle = .formSheet
//
//        let editNavigationController = UINavigationController(
//            rootViewController: editViewController
//        )
//        present(editNavigationController, animated: true)
//    }
}
