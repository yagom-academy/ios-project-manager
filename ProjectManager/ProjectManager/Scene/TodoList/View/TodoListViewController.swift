//
//  ProjectManager - TodoListViewController.swift
//  Created by yagom.
//  Copyright © yagom. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

private enum Const {
    static let plus = "plus"
    static let projectManager = "Project Manager"
}

final class TodoListViewController: UIViewController {
    private let todoView: ListView
    private let doingView: ListView
    private let doneView: ListView
    private let viewModel: TodoListViewModel
    private let disposeBag = DisposeBag()
    weak private var coordinator: AppCoordinator?
    
    private let tablesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.backgroundColor = .systemGray5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let rightBarButton = UIBarButtonItem(
        image: UIImage(systemName: Const.plus),
        style: .plain,
        target: nil,
        action: nil
    )
    
    private let networkBarButton = UIBarButtonItem(
        image: UIImage(systemName: "wifi.slash"),
        style: .plain,
        target: nil,
        action: nil
    )
    
    private let historyBarButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "clock"),
            style: .plain,
            target: nil,
            action: nil
        )
        barButtonItem.isEnabled = false
        
        return barButtonItem
    }()
    
    private let undoBarButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "arrow.uturn.backward"),
            style: .plain,
            target: nil,
            action: nil
        )
        barButtonItem.isEnabled = false
        
        return barButtonItem
    }()
    
    private let redoBarButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "arrow.uturn.forward"),
            style: .plain,
            target: nil,
            action: nil
        )
        barButtonItem.isEnabled = false
        
        return barButtonItem
    }()
    
    init(todoViewModel: TodoListViewModel, coordinator: AppCoordinator) {
        self.todoView = ListView(todoListItemStatus: .todo, listViewModel: todoViewModel, coordinator: coordinator)
        self.doingView = ListView(todoListItemStatus: .doing, listViewModel: todoViewModel, coordinator: coordinator)
        self.doneView = ListView(todoListItemStatus: .done, listViewModel: todoViewModel, coordinator: coordinator)
        self.viewModel = todoViewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTablesStackView()
        self.setUpNavigation()
        self.bind()
    }
    
    private func setUpTablesStackView() {
        self.view.addSubview(self.tablesStackView)
        
        self.tablesStackView.addArrangedSubviews(with: [
            self.todoView,
            self.doingView,
            self.doneView
        ])
        
        NSLayoutConstraint.activate([
            self.tablesStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tablesStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tablesStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tablesStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setUpNavigation() {
        self.view.backgroundColor = .systemBackground
        self.title = Const.projectManager
        self.navigationItem.rightBarButtonItems = [self.rightBarButton, self.networkBarButton]
        self.navigationItem.leftBarButtonItems = [self.historyBarButton, self.undoBarButton, self.redoBarButton]
    }
    
    private func bind() {
        self.rightBarButton.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] in
                self?.coordinator?.showDetailView()
            })
            .disposed(by: self.disposeBag)
        
        self.viewModel.networkState
            .map { UIImage(systemName: $0) }
            .drive(self.networkBarButton.rx.image)
            .disposed(by: self.disposeBag)
        
        self.historyBarButton.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] in
                self?.coordinator?.showHistory(historyButton: self?.historyBarButton)
            })
            .disposed(by: self.disposeBag)
        
        self.viewModel.historyList
            .drive(onNext: { [weak self] isHistory in
                self?.isUndoButtonActive(isHistoryData: isHistory)
                self?.isHistoryButtonActive(isHistoryData: isHistory)
            })
            .disposed(by: self.disposeBag)
        
        self.undoBarButton.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] in
                self?.viewModel.undoButtonTapEvent()
            })
            .disposed(by: self.disposeBag)
        
        self.viewModel.undoList
            .drive(onNext: { [weak self] isUndo in
                self?.isRedoButtonActive(isUndoData: isUndo)
            })
            .disposed(by: self.disposeBag)
        
        self.redoBarButton.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] in
                self?.viewModel.redoButtonTapEvent()
            })
            .disposed(by: self.disposeBag)
    }
    
    private func isHistoryButtonActive(isHistoryData: Bool) {
        if isHistoryData {
            self.historyBarButton.isEnabled = true
        } else {
            self.historyBarButton.isEnabled = false
        }
    }

    private func isUndoButtonActive(isHistoryData: Bool) {
        if isHistoryData {
            self.undoBarButton.isEnabled = true
        } else {
            self.undoBarButton.isEnabled = false
        }
    }

    private func isRedoButtonActive(isUndoData: Bool) {
        if isUndoData {
            self.redoBarButton.isEnabled = true
        } else {
            self.redoBarButton.isEnabled = false
        }
    }
}
