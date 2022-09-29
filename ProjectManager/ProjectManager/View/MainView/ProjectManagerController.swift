//
//  ProjectManager - ProjectManagerController.swift
//  Created by 수꿍, 휴 on 2022/09/07.
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class ProjectManagerController: UIViewController, UIPopoverPresentationControllerDelegate {

    private let toDoViewModel = ToDoViewModel(databaseManager: LocalDatabaseManager.onDisk)
    private let doingViewModel = DoingViewModel(databaseManager: LocalDatabaseManager.onDisk)
    private let doneViewModel = DoneViewModel(databaseManager: LocalDatabaseManager.onDisk)

    private lazy var toDoViewController = ProjectListViewController(
        viewModel: toDoViewModel
    )
    private lazy var doingViewController = ProjectListViewController(
        viewModel: doingViewModel
    )
    private lazy var doneViewController = ProjectListViewController(
        viewModel: doneViewModel
    )

    private let historyController = HistoryPopoverController()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .systemGray4
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10

        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        observeNetworkConnect()
        configureNavigationItems()
        configureUI()
        configureObservers()
    }
    
    private func configureNavigationItems() {
        self.title = "Project Manager"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "History",
            style: .plain,
            target: self,
            action: #selector(didTapHistoryButton)
        )
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didTapAddButton)
        )
    }
    
    @objc private func didTapHistoryButton() {
        historyController.modalPresentationStyle = .popover
        historyController.preferredContentSize = CGSize(width: 600, height: 600)
        
        guard let popoverController = historyController.popoverPresentationController else {
            return
        }
        
        popoverController.delegate = self
        popoverController.permittedArrowDirections = .up
        popoverController.sourceView = self.view
        popoverController.barButtonItem = navigationItem.leftBarButtonItem
        
        self.present(historyController, animated: true)
    }
    
    @objc private func didTapAddButton() {
        let projectAdditionController = ProjectAdditionController()
        projectAdditionController.viewModel = self.toDoViewController.viewModel as? ContentAddible

        let navigationController = UINavigationController(rootViewController: projectAdditionController)
        navigationController.modalPresentationStyle = .formSheet

        self.present(navigationController, animated: true)
    }
    
    private func configureUI() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(stackView)
        self.stackView.addArrangedSubview(toDoViewController.view)
        self.stackView.addArrangedSubview(doingViewController.view)
        self.stackView.addArrangedSubview(doneViewController.view)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func configureObserver(in viewModel: CommonViewModelLogic) {
        viewModel.registerMovingHistory = { [weak self] (title, previous, next) in
            self?.historyController.configureSnapshotItem(data: HistoryLog(
                content: "Moved '\(title)' from \(previous) to \(next).",
                time: Date())
            )

            guard let snapshot = self?.historyController.snapshot else {
                return
            }

            self?.historyController.dataSource?.apply(snapshot)
            self?.historyController.tableView.reloadData()
        }

        viewModel.registerDeletionHistory = { [weak self] (title, schedule) in
            self?.historyController.configureSnapshotItem(data: HistoryLog(
                content: "Removed '\(title)' from \(schedule)",
                time: Date())
            )

            guard let snapshot = self?.historyController.snapshot else {
                return
            }

            self?.historyController.dataSource?.apply(snapshot)
            self?.historyController.tableView.reloadData()
        }

        guard var viewModel = viewModel as? ContentAddible else {
            return
        }

        viewModel.registerAdditionHistory = { [weak self] (title) in
            self?.historyController.configureSnapshotItem(data: HistoryLog(
                content: "Added '\(title)'.",
                time: Date())
            )

            guard let snapshot = self?.historyController.snapshot else {
                return
            }

            self?.historyController.dataSource?.apply(snapshot)
            self?.historyController.tableView.reloadData()
        }
    }

    private func configureObservers() {
        configureObserver(in: toDoViewModel)
        configureObserver(in: doingViewModel)
        configureObserver(in: doneViewModel)
    }
    
    private func observeNetworkConnect() {
        NetworkObserver.shared.startObserving(completion: { [weak self] isConnected in
            guard let self = self else {
                return
            }
            
            if isConnected == true {
                self.synchronizeDatabase()
            } else {
                let alert = UIAlertController(title: "연결 실패", message: "네트워트 연결에 실패했습니다.", preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .default, handler: nil)
                
                alert.addAction(action)
                DispatchQueue.main.async {
                    self.present(alert, animated: true)
                }
            }
        })
        NetworkObserver.shared.stopObserving()
    }
    
    private func synchronizeDatabase() {
        if LocalDatabaseManager.onDisk.isEmpty() {
            RemoteDatabaseManager.shared.fetch { result in
                switch result {
                case .success(let data):
                    data.forEach { project in
                        try? LocalDatabaseManager.onDisk.create(data: project)
                    }
                case .failure(.defaultError):
                    let alert = UIAlertController(title: "에러 발생", message: "원격 데이터 베이스 에러 발생", preferredStyle: .alert)
                    let action = UIAlertAction(title: "확인", style: .default, handler: nil)
                    
                    alert.addAction(action)
                    DispatchQueue.main.async {
                        self.present(alert, animated: true)
                    }
                case .failure(.emptyError):
                    return
                }
            }
        } else {
            guard let localData = try? LocalDatabaseManager.onDisk.fetchAllData() else {
                return
            }

            RemoteDatabaseManager.shared.fetch { result in
                switch result {
                case .success(let remoteData):
                    if localData.count == remoteData.count {
                        for i in 0..<localData.count {
                            if localData[i] == remoteData[i] {
                                continue
                            } else {
                                try? RemoteDatabaseManager.shared.save(data: localData[i])
                            }
                        }
                    }
                default:
                    break
                }
            }
        }
    }
}
