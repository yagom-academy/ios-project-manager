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

    private var planManager: PlanManager
    private let viewModel: PlanListViewModel
    private let planListStackViews: [PlanListView]
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

    init(planManger: PlanManager = ProjectManager.shared,
         viewModel: PlanListViewModel = ProjectListViewModel(),
         planListStackViews: [PlanListView] = [ProjectListView(state: .toDo,
                                                                         frame: .zero),
                                                    ProjectListView(state: .doing,
                                                                         frame: .zero),
                                                    ProjectListView(state: .done,
                                                                         frame: .zero)]) {
        self.planManager = planManger
        self.viewModel = viewModel
        self.planListStackViews = planListStackViews
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
        planListStackViews.forEach { listView in
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

extension PlanListViewController: PlanListViewDelegate {
    func configureList(state: State) -> [PlanViewModel] {
        switch state {
        case .toDo:
            return viewModel.fetchList(of: .toDo)
        case .doing:
            return viewModel.fetchList(of: .doing)
        case .done:
            return viewModel.fetchList(of: .done)
        }
    }
}
