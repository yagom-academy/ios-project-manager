//
//  MainViewController.swift
//  ProjectManager
//
//  Created by som on 2023/01/25.
//

import UIKit

final class MainViewController: UIViewController {
    private enum LayoutConstraint {
        static let spacing: CGFloat = 8
    }

    private let alertManager = AlertManager()
    private lazy var todoListViewController = PlanListViewController(status: .todo,
                                                                      delegate: self,
                                                                      tableView: PlanTableView())
    private lazy var doingListViewController = PlanListViewController(status: .doing,
                                                                      delegate: self,
                                                                      tableView: PlanTableView())
    private lazy var doneListViewController = PlanListViewController(status: .done,
                                                                      delegate: self,
                                                                      tableView: PlanTableView())
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = LayoutConstraint.spacing
        stackView.backgroundColor = .systemGray6
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        configureView()
    }

    private func configureNavigationBarButton() -> UIBarButtonItem {
        let detailViewController = PlanDetailViewController(navigationTitle: Content.toDo,
                                                            plan: nil,
                                                            isAdding: true)

        let buttonAction = UIAction { [weak self] _ in
            self?.present(detailViewController, animated: true)
        }

        return UIBarButtonItem(systemItem: .add, primaryAction: buttonAction)
    }

    private func configureView() {
        view.addSubview(stackView)

        [todoListViewController, doingListViewController, doneListViewController].forEach {
            addChild($0)
            stackView.addArrangedSubview($0.view)
            $0.didMove(toParent: self)
        }

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    private func configureNavigationBar() {
        navigationItem.title = Content.navigationTitle
        navigationItem.rightBarButtonItem = configureNavigationBarButton()
    }
}

extension MainViewController: PlanListDelegate {
    func sendToAdd(plan: Plan) {
        switch plan.status {
        case .todo:
            todoListViewController.add(plan: plan)
        case .doing:
            doingListViewController.add(plan: plan)
        case .done:
            doneListViewController.add(plan: plan)
        }
    }

    func sendToUpdate(plan: Plan) {
        switch plan.status {
        case .todo:
            todoListViewController.updateStatus(plan: plan)
        case .doing:
            doingListViewController.updateStatus(plan: plan)
        case .done:
            doneListViewController.updateStatus(plan: plan)
        }
    }
}
