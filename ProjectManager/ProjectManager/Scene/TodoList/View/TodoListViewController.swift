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
        self.navigationItem.rightBarButtonItem = self.rightBarButton
    }
    
    private func bind() {
        self.rightBarButton.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] in
                self?.coordinator?.showDetailView()
            })
            .disposed(by: self.disposeBag)
    }
}
