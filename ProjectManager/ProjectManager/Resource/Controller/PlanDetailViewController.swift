//
//  ToDoDetailViewController.swift
//  ProjectManager
//
//  Created by som on 2023/01/11.
//

import UIKit

class PlanDetailViewController: UIViewController {
    private lazy var planDetailView = PlanDetailView(frame: view.bounds)
    private var plan: Plan?
    private let navigationTitle: String
    private let isAdding: Bool
    private let changedPlan: (Plan?) -> Void
    private let planManager = PlanManager()

    // TODO: plan create가 안 되고 있음
    // TODO: plan을 생성하는 시점이 모달 뷰가 사라질 때로 해보자 -> 빈 값이면 삭제, create가 아닌 save 느낌으로
    init(navigationTitle: String, plan: Plan?, isAdding: Bool, changedPlan: @escaping (Plan?) -> Void) {
        self.navigationTitle = navigationTitle
        self.plan = plan
        self.isAdding = isAdding
        self.changedPlan = changedPlan
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setAddMode()
        setViewMode()
    }

    private func configureView() {
        view.addSubview(planDetailView)

        planDetailView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    private func setAddMode() {
        configureNavigationItem(leftButton: configureNavigationCancelBarButton(),
                                rightButton: configureNavigationDoneBarButton())
    }

    private func setViewMode() {
        if isAdding == false {
            configureNavigationItem(leftButton: configureNavigationEditBarButton(),
                                    rightButton: configureNavigationDoneBarButton())


            planDetailView.configureTextView(title: plan?.title ?? "",
                                             description: plan?.description ?? "",
                                             deadline: plan?.deadline ?? Date(),
                                             isEditable: false)
        }
    }

    private func setEditMode() {
        configureNavigationItem(leftButton: configureNavigationCancelBarButton(),
                                rightButton: configureNavigationDoneBarButton())

        if isAdding == false {
            planDetailView.configureTextView(title: plan?.title ?? "",
                                             description: plan?.description ?? "",
                                             deadline: plan?.deadline ?? Date(),
                                             isEditable: true)
        }
    }

    private func configureNavigationItem(leftButton: UIBarButtonItem, rightButton: UIBarButtonItem) {
        let navigationItem = UINavigationItem(title: "TODO")

        let leftBarButton = leftButton
        let rightBarButton = rightButton

        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = rightBarButton

        planDetailView.configureNavigationBar(on: navigationItem)
    }

    private func configureNavigationCancelBarButton() -> UIBarButtonItem {
        let buttonAction = UIAction { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }

        let button = UIBarButtonItem(systemItem: .cancel, primaryAction: buttonAction)

        return button
    }

    private func configureNavigationEditBarButton() -> UIBarButtonItem {
        let buttonAction = UIAction { [weak self] _ in
            self?.setEditMode()
        }

        let button = UIBarButtonItem(systemItem: .edit, primaryAction: buttonAction)

        return button
    }

    private func configureNavigationDoneBarButton() -> UIBarButtonItem {
        let buttonAction = UIAction { [weak self] _ in
            self?.save()
            self?.changedPlan(self?.plan)

            self?.dismiss(animated: true, completion: nil)
        }

        let button = UIBarButtonItem(systemItem: .done, primaryAction: buttonAction)

        return button
    }

    private func save() {
        let inputPlan = planDetailView.sendUserPlan() 

        if planManager.fetch(id: plan?.id) == nil {
            plan = planManager.create(title: inputPlan.title,
                                          description: inputPlan.description,
                                          deadline: inputPlan.deadline)
        } else {
            plan?.title = inputPlan.title
            plan?.description = inputPlan.description
            plan?.deadline = inputPlan.deadline
        }
    }
}
 
