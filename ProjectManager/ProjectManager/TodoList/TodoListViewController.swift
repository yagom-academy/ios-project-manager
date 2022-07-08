//
//  ProjectManager - TodoListViewController.swift
//  Created by yagom.
//  Copyright © yagom. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

final class TodoListViewController: UIViewController {
    private let todoView: ListView
    private let doingView: ListView
    private let doneView: ListView
    private let viewModel: TodoListViewModel
    private let disposeBag = DisposeBag()

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

    init() {
        self.todoView = ListView(status: .todo)
        self.doingView = ListView(status: .doing)
        self.doneView = ListView(status: .done)
        self.viewModel = TodoListViewModel()
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

        self.tablesStackView.addArrangedSubviews(with: [self.todoView, self.doingView, self.doneView])

        NSLayoutConstraint.activate([
            self.tablesStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tablesStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tablesStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tablesStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func setUpNavigation() {
        self.view.backgroundColor = .systemBackground
        self.title = "Project Manager"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: nil,
            action: nil)
    }
    
    private func bind() {
        self.navigationItem.rightBarButtonItem?.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] in
                self?.moveToDetailView() })
            .disposed(by: disposeBag)
    }
    
    private func moveToDetailView() {
        let viewController = DetailViewController()

        viewController.modalPresentationStyle = .formSheet
        self.present(viewController, animated: true)
    }
}
