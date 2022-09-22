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
    private var longpressState: ProjectTaskState?
    
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
        view.backgroundColor = .systemGray5
        mainView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupNavigationBarItem() {
        let naviItem = UINavigationItem(title: MainViewCommand.mainViewNavigationBarTitle)
        naviItem.leftBarButtonItem = setupLeftBarButtonItem()
        naviItem.rightBarButtonItem =  setupRightBarButtonItem()
        mainView.navigationBar.setItems([naviItem], animated: true)
    }
    
    func setupLeftBarButtonItem() -> UIBarButtonItem{
        let leftBarButtonItem = UIBarButtonItem(title: "History")
        
        leftBarButtonItem.rx.tap.bind {
            print("Tapped MainView - History Button ")
        }.disposed(by: disposedBag)
        
        return leftBarButtonItem

    }
    
    func setupRightBarButtonItem() -> UIBarButtonItem{
        let rightBarButtonItem = UIBarButtonItem(systemItem: .add)
        
        rightBarButtonItem.rx.tap.bind {
            self.rightBarButtonDidTap()
        }.disposed(by: disposedBag)
        
        return rightBarButtonItem
    }
    
    func rightBarButtonDidTap() {
        let todoAddViewController = TodoAddViewController()
        todoAddViewController.state = .TODO
        todoAddViewController.isNewTask = true
        todoAddViewController.viewModel = viewModel
        todoAddViewController.modalPresentationStyle = .pageSheet
        
        self.present(todoAddViewController, animated: true)
    }
    
    
    //MARK: - View Changed Method
    
    func pushViewControllerToDetailViewController(
        projectState: ProjectTaskState,
        viewModel: ProjectTaskViewModel
    ) {
        let todoAddViewController = TodoAddViewController()
        todoAddViewController.viewModel = viewModel
        todoAddViewController.state = projectState
        todoAddViewController.modalPresentationStyle = .pageSheet
        
        self.present(todoAddViewController, animated: true)
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
             .bind(to: mainView.todoListView.mainTableView.rx.items(cellIdentifier: MainViewCommand.cellReuseIdentifier)) {
                (index: Int, element: ProjectTask, cell: ProjectTaskCell) in
                let longPressGestureRecognizer = CustomLongPressGesture(
                    target: self,
                    action: #selector(self.longPressCell)
                )
                longPressGestureRecognizer.taskState = .TODO
                longPressGestureRecognizer.cellID = element.id
                cell.addGestureRecognizer(longPressGestureRecognizer)
                cell.configureDeadLineLabel(date: element.date)
                cell.setupData(element)
            }
            .disposed(by: disposedBag)
        
        viewModel.doingTasks
            .bind(to: mainView.doingListView.mainTableView.rx.items(cellIdentifier: MainViewCommand.cellReuseIdentifier)) {
                (index: Int, element: ProjectTask, cell: ProjectTaskCell) in
                let longPressGestureRecognizer = CustomLongPressGesture(
                    target: self,
                    action: #selector(self.longPressCell)
                )
                longPressGestureRecognizer.taskState = .DOING
                longPressGestureRecognizer.cellID = element.id
                cell.addGestureRecognizer(longPressGestureRecognizer)
                cell.configureDeadLineLabel(date: element.date)
                cell.setupData(element)
            }
            .disposed(by: disposedBag)
        
        viewModel.doneTasks
            .bind(to: mainView.doneListView.mainTableView.rx.items(cellIdentifier: MainViewCommand.cellReuseIdentifier)) {
                (index: Int, element: ProjectTask, cell: ProjectTaskCell) in
                let longPressGestureRecognizer = CustomLongPressGesture(
                    target: self,
                    action: #selector(self.longPressCell)
                )
                longPressGestureRecognizer.taskState = .DONE
                longPressGestureRecognizer.cellID = element.id
                cell.addGestureRecognizer(longPressGestureRecognizer)
                cell.configureDeadLineLabel(date: element.date)
                cell.setupData(element)
            }
            .disposed(by: disposedBag)
    }
    
    @objc func longPressCell(_ sender: CustomLongPressGesture) {
        guard let taskState = sender.taskState,
              let cellID = sender.cellID else {
            return
        }
        
        presentMoveAlert(at: taskState, id: cellID)
    }
    
    func presentMoveAlert(at state: ProjectTaskState, id: UUID) {
        let moveAlertViewController = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .alert
        )
        let targetState = state.moveUpperActionTarget()
        
        let moveToUpperAction = UIAlertAction(title: "Move to \(targetState.upper)", style: .default) { (action) in
            self.viewModel.moveTask(to: targetState.upper, from: state, id: id)
        }
        let moveToLowerAction = UIAlertAction(title: "Move to \(targetState.lower)", style: .default) { (action) in
            self.viewModel.moveTask(to: targetState.lower, from: state, id: id)
        }
        
        moveAlertViewController.addAction(moveToUpperAction)
        moveAlertViewController.addAction(moveToLowerAction)
        
        self.present(moveAlertViewController, animated: true) {
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.didTappedOutside(_:)))
            moveAlertViewController.view.superview?.isUserInteractionEnabled = true
            moveAlertViewController.view.superview?.addGestureRecognizer(tap)
        }
    }
    
    @objc private func didTappedOutside(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupHeaderCountBinding() {
        viewModel.todoCount
            .subscribe(onNext: { count in
                self.mainView.todoListView.countLabel.text = String(count)
            })
            .disposed(by: disposedBag)
        
        viewModel.doingCount
            .subscribe(onNext: { count in
                self.mainView.doingListView.countLabel.text = String(count)
            })
            .disposed(by: disposedBag)
        
        viewModel.doneCount
            .subscribe(onNext: { count in
                self.mainView.doneListView.countLabel.text = String(count)
            })
            .disposed(by: disposedBag)
    }
    
    func setupTaskSelectedBinding() {
        Observable.zip(mainView.todoListView.mainTableView.rx.modelSelected(ProjectTask.self),
                       mainView.todoListView.mainTableView.rx.itemSelected)
        .subscribe(onNext: { (item, indexPath) in
            self.viewModel.selectedTask = item
            self.pushViewControllerToDetailViewController(
                projectState: .TODO,
                viewModel: self.viewModel
            )
            self.mainView.todoListView.mainTableView.deselectRow(at: indexPath, animated: true)
        })
        .disposed(by: disposedBag)
        
        Observable.zip(mainView.doingListView.mainTableView.rx.modelSelected(ProjectTask.self),
                       mainView.doingListView.mainTableView.rx.itemSelected)
        .subscribe(onNext: { (item, indexPath) in
            self.viewModel.selectedTask = item
            self.pushViewControllerToDetailViewController(
                projectState: .DOING,
                viewModel: self.viewModel
            )
            self.mainView.doingListView.mainTableView.deselectRow(at: indexPath, animated: true)
        })
        .disposed(by: disposedBag)
        
        Observable.zip(mainView.doneListView.mainTableView.rx.modelSelected(ProjectTask.self),
                       mainView.doneListView.mainTableView.rx.itemSelected)
        .subscribe(onNext: { (item, indexPath) in
            self.viewModel.selectedTask = item
            self.pushViewControllerToDetailViewController(
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
