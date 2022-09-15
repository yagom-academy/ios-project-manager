//
//  ProjectManager - MainViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import RxSwift
import RxCocoa

final class MainViewController: UIViewController {
    
    //MARK: - UI Properties
    
    private lazy var mainView = MainView(frame: view.safeAreaLayoutGuide.layoutFrame)
    private let viewModel = ProjectTaskViewModel()
    private let disposedBag = DisposeBag()
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainView()
        setupNavigationBarItem()
        setupBinding()
    }
}

private extension MainViewController {
    
    //MARK: - Root View Setup
    func setupMainView() {
        view.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupNavigationBarItem() {
        navigationItem.title = MainViewCommand.mainViewNavigationBarTitle
        view.backgroundColor = .systemGray5
        setupRightBarButtonItem()
    }
    
    func setupRightBarButtonItem() {
        let rightBarButtonItem = UIBarButtonItem(systemItem: .add)
        rightBarButtonItem.target = self
        rightBarButtonItem.action = #selector(rightBarButtonDidTap)
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
    }
    
    @objc func rightBarButtonDidTap() {
        let todoAddViewController = TodoAddViewController()
        todoAddViewController.state = .TODO
        
        let presentNavigationController = UINavigationController(rootViewController: todoAddViewController)
        presentNavigationController.modalPresentationStyle = .pageSheet
        
        self.navigationController?.present(presentNavigationController, animated: true)
    }
    
    
    //MARK: - View Changed Method
    
    func pushViewControllerWithNavigationController(
        with task: ProjectTask,
        projectState: ProjetTaskState,
        viewModel: ProjectTaskViewModel
    ) {
        let todoAddViewController = TodoAddViewController()
        todoAddViewController.projectTask = task
        
        let presentNavigationController = UINavigationController(rootViewController: todoAddViewController)
        presentNavigationController.modalPresentationStyle = .pageSheet
        
        self.navigationController?.present(presentNavigationController, animated: true)
    }
}

private extension MainViewController {
    
    //MARK: Binding ViewModel
    
    func setupBinding() {
        setupTableViewBinding()
        setupHeaderCountBinding()
        setupTaskSelectedBinding()
        setupTaskSwipeDeleteBinding()
    }
    
    func setupTableViewBinding() {
        viewModel.todoTasks
            .observe(on: MainScheduler.instance)
            .bind(to: mainView.todoListView.mainTableView.rx.items(cellIdentifier: MainViewCommand.cellReuseIdentifier)) {
                (index: Int, element: ProjectTask, cell: ProjectTaskCell) in
                cell.setupData(element)
            }
            .disposed(by: disposedBag)
        
        viewModel.doneTasks
            .observe(on: MainScheduler.instance)
            .bind(to: mainView.doneListView.mainTableView.rx.items(cellIdentifier: MainViewCommand.cellReuseIdentifier)) {
                (index: Int, element: ProjectTask, cell: ProjectTaskCell) in
                cell.setupData(element)
            }
            .disposed(by: disposedBag)
        
        viewModel.doingTasks
            .observe(on: MainScheduler.instance)
            .bind(to: mainView.doingListView.mainTableView.rx.items(cellIdentifier: MainViewCommand.cellReuseIdentifier)) {
                (index: Int, element: ProjectTask, cell: ProjectTaskCell) in
                cell.setupData(element)
            }
            .disposed(by: disposedBag)
    }
    
    func setupHeaderCountBinding() {
        viewModel.todoCount
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] count in
                self?.mainView.todoListView.countLabel.text = String(count)
            })
            .disposed(by: disposedBag)
        
        viewModel.doingCount
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] count in
                self?.mainView.doingListView.countLabel.text = String(count)
            })
            .disposed(by: disposedBag)
        
        viewModel.doneCount
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] count in
                self?.mainView.doneListView.countLabel.text = String(count)
            })
            .disposed(by: disposedBag)
    }
    
    func setupTaskSelectedBinding() {
        Observable.zip(mainView.todoListView.mainTableView.rx.modelSelected(ProjectTask.self),
                       mainView.todoListView.mainTableView.rx.itemSelected)
        .observe(on: MainScheduler.instance)
        .subscribe(onNext: { [weak self] (item, indexPath) in
            guard let self = self else {
                return
            }
            self.pushViewControllerWithNavigationController(
                with: item,
                projectState: .TODO,
                viewModel: self.viewModel
            )
            self.mainView.todoListView.mainTableView.deselectRow(at: indexPath, animated: true)
        })
        .disposed(by: disposedBag)
        
        Observable.zip(mainView.doingListView.mainTableView.rx.modelSelected(ProjectTask.self),
                       mainView.doingListView.mainTableView.rx.itemSelected)
        .observe(on: MainScheduler.instance)
        .subscribe(onNext: { [weak self] (item, indexPath) in
            guard let self = self else {
                return
            }
            self.pushViewControllerWithNavigationController(
                with: item,
                projectState: .DOING,
                viewModel: self.viewModel
            )
            self.mainView.doingListView.mainTableView.deselectRow(at: indexPath, animated: true)
        })
        .disposed(by: disposedBag)
        
        Observable.zip(mainView.doneListView.mainTableView.rx.modelSelected(ProjectTask.self),
                       mainView.doneListView.mainTableView.rx.itemSelected)
        .observe(on: MainScheduler.instance)
        .subscribe(onNext: { [weak self] (item, indexPath) in
            guard let self = self else {
                return
            }
            self.pushViewControllerWithNavigationController(
                with: item,
                projectState: .DONE,
                viewModel: self.viewModel
            )
            self.mainView.doneListView.mainTableView.deselectRow(at: indexPath, animated: true)
        })
        .disposed(by: disposedBag)
    }
    
    func setupTaskSwipeDeleteBinding() {
        mainView.todoListView.mainTableView.rx.itemDeleted
            .subscribe(onNext: { task in
                self.viewModel.deleteTask(at: .TODO, what: task.row)
            }).disposed(by: disposedBag)
        
        mainView.doingListView.mainTableView.rx.itemDeleted
            .subscribe(onNext: { task in
                self.viewModel.deleteTask(at: .DOING, what: task.row)
            }).disposed(by: disposedBag)
        
        mainView.doneListView.mainTableView.rx.itemDeleted
            .subscribe(onNext: { task in
                self.viewModel.deleteTask(at: .DONE, what: task.row)
            }).disposed(by: disposedBag)
    }
}
