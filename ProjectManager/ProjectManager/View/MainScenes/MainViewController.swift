//
//  ProjectManager - MainViewController.swift
//  Created by yagom.
//  Copyright © yagom. All rights reserved.
//

import UIKit

protocol DataSharable: AnyObject {
    func shareData(data: Plan)
}

protocol GestureRelayable: AnyObject {
    func relayGesture(
        _ sender: UILongPressGestureRecognizer,
        indexPath: IndexPath,
        cell: UITableViewCell
    )
}

final class MainViewController: UIViewController {
    typealias DataSource = UITableViewDiffableDataSource<Section, Plan>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Plan>
    
    enum Section {
        case main
    }
    
    private enum UIConstant {
        static let navigationTitle = "Project Manager"
        static let deleteSwipeTitle = "Delete"
        static let tableSpacing = 10.0
        static let bottomValue = -50.0
        static let headerSectionHeight = 7.0
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
        setupConstraint()
    }
    
    @objc private func addButtonTapped() {
        viewModel.setupUploadDataProcess(process: .todo)
        viewModel.setupUploadDataIndex(index: nil)
        
        presentDetailView()
    }
    
    private func setupBinding() {
        viewModel.bindTodo { [weak self] data in
            self?.todoView.changeCountLabel(String(data.count))
            self?.applySnapshot(process: .todo, data: data, animating: true)
        }
        
        viewModel.bindDoing { [weak self] data in
            self?.doingView.changeCountLabel(String(data.count))
            self?.applySnapshot(process: .doing, data: data, animating: true)
        }
        
        viewModel.bindDone { [weak self] data in
            self?.doneView.changeCountLabel(String(data.count))
            self?.applySnapshot(process: .done, data: data, animating: true)
        }
    }
    
    private func presentDetailView() {
        let selectedData = viewModel.fetchSeletedData()
        let detailViewModel = DetailViewModel(data: selectedData)
        
        let detailViewController = DetailViewController(
            viewModel: detailViewModel
        )
        
        detailViewController.delegate = self
        detailViewController.modalPresentationStyle = .formSheet
        
        let detailNavigationController = UINavigationController(
            rootViewController: detailViewController
        )
        present(detailNavigationController, animated: true)
    }
    
    private func checkSelectTableProcess(tableView: UITableView) -> Process? {
        switch tableView {
        case todoView.tableView:
            return .todo
        case doingView.tableView:
            return .doing
        case doneView.tableView:
            return .done
        default:
            return nil
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
    
    private func setupView() {
        view.backgroundColor = .systemGray6
        view.addSubview(mainStackView)
        [todoView, doingView, doneView].forEach {
            $0.tableView.delegate = self
            $0.delegate = self
        }
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
        
        let dataSource = DataSource(tableView: tableView) { tableView, indexPath, todoData in
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ProcessTableViewCell.identifier,
                for: indexPath
            ) as? ProcessTableViewCell else {
                let errorCell = UITableViewCell()
                return errorCell
            }
            
            cell.viewModel = CellViewModel(data: todoData)
            return cell
        }
        return dataSource
    }
    
    private func applySnapshot(process: Process, data: [Plan], animating: Bool) {
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

// MARK: - TableView Delegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UIConstant.headerSectionHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let process = checkSelectTableProcess(tableView: tableView) else { return }
        
        viewModel.setupUploadDataProcess(process: process)
        viewModel.setupUploadDataIndex(index: indexPath.row)
        
        presentDetailView()
    }
    
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(
            style: .normal,
            title: UIConstant.deleteSwipeTitle
        ) { _, _, _ in
            
            guard let process = self.checkSelectTableProcess(tableView: tableView) else { return }
            
            self.viewModel.setupUploadDataIndex(index: indexPath.row)
            self.viewModel.setupUploadDataProcess(process: process)
            self.viewModel.deleteData()
        }
        
        delete.backgroundColor = .red
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [delete])
        swipeConfiguration.performsFirstActionWithFullSwipe = true
        return swipeConfiguration
    }
}

// MARK: - DataSharable Delegate Protocol
extension MainViewController: DataSharable {
    func shareData(data: Plan) {
        viewModel.updateData(data: data)
    }
}

// MARK: - GestureRelayable Protocol & POPOver Alert
extension MainViewController: GestureRelayable {
    func relayGesture(
        _ sender: UILongPressGestureRecognizer,
        indexPath: IndexPath,
        cell: UITableViewCell
    ) {
        showPopover(sender: sender, cell: cell, indexPath: indexPath)
    }
    
    private func showPopover(
        sender: UILongPressGestureRecognizer,
        cell: UITableViewCell,
        indexPath: IndexPath
    ) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        guard let tableView = sender.view as? UITableView else { return }
        guard let selectProcess = checkSelectTableProcess(tableView: tableView) else { return }
        
        viewModel.setupUploadDataProcess(process: selectProcess)
        viewModel.setupUploadDataIndex(index: indexPath.row)
        
        Process.allCases.filter {
            $0 != selectProcess
        }.forEach { process in
            let action = UIAlertAction(
                title: "Move To \(process.titleValue)",
                style: .default
            ) { [weak self] _ in
                self?.viewModel.changeProcess(after: process, index: indexPath.row)
                self?.dismiss(animated: true)
            }
            alert.addAction(action)
        }
        
        guard let popover = alert.popoverPresentationController else { return }
        popover.sourceView = cell.contentView
        
        present(alert, animated: true)
    }
}
