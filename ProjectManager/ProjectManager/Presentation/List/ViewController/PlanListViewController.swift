//
//  ProjectManager - PlanListViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class PlanListViewController: UIViewController {
    
    typealias Text = Constant.Text
    typealias Style = Constant.Style
    typealias Color = Constant.Color

    private var viewModel: ListViewModel?
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = Color.PlanListViewSpacing
        stackView.axis = .horizontal
        stackView.spacing = Style.stackViewSpacing
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUIComponent()
    }

    private func configureUIComponent() {
        configureNavigationBar()
        configureViewHierarchy()
        configureLayoutConstraint()
    }

    private func configureNavigationBar() {
        navigationItem.title = Text.navigationTitle
        navigationItem.rightBarButtonItem = addPlanButton()
    }

    private func configureViewHierarchy() {
        view.addSubview(stackView)
        State.allCases.forEach { state in
            let listView = ProjectListView(state: state,
                                           frame: .zero)
            stackView.addArrangedSubview(listView)
        }
    }

    private func configureLayoutConstraint() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                              constant: Style.stackViewBottomInset),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }

    private func presentPlanView(viewModel: PlanViewModel) {
        let planViewController = PlanViewController(viewModel: viewModel)

        planViewController.modalPresentationStyle = .formSheet
        present(planViewController, animated: true)
    }

    private func addPlanAction() -> UIAction {
        let action = UIAction { _ in
            self.presentPlanView(viewModel: ProjectViewModel())
        }

        return action
    }

    private func addPlanButton() -> UIBarButtonItem {
        let button = UIBarButtonItem(systemItem: .add, primaryAction: addPlanAction())

        return button
    }
}
