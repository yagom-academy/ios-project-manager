//
//  ProjectManager - TodoListViewController.swift
//  Created by yagom.
//  Copyright © yagom. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

final class TodoListViewController: UIViewController {
    private var todoView: ListView
    private var doingView: ListView
    private var doneView: ListView
    private let viewModel: TodoListViewModel
    private let disposeBag = DisposeBag()

    private let entireStackView: UIStackView = {
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
        self.todoView = ListView(mode: .todo)
        self.doingView = ListView(mode: .doing)
        self.doneView = ListView(mode: .done)
        self.viewModel = TodoListViewModel()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        self.setUpNavigation()
    }

    private func setUpView() {
        self.view.addSubview(self.entireStackView)

        self.entireStackView.addArrangedSubviews(with: [self.todoView, self.doingView, self.doneView])

        NSLayoutConstraint.activate([
            self.entireStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.entireStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.entireStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.entireStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
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
}
