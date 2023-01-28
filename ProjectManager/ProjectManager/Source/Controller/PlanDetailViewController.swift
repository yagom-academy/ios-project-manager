//
//  ToDoDetailViewController.swift
//  ProjectManager
//
//  Created by som on 2023/01/11.
//

import UIKit

final class PlanDetailViewController: UIViewController {
    private lazy var planDetailView = PlanDetailView(frame: view.bounds)
    private var plan: Plan?
    private let navigationTitle: String
    private let isAdding: Bool
    private let planManager = PlanManager()
    private let alertManager = AlertManager()
    private var planDelegate: PlanDelegate?

    init(navigationTitle: String, plan: Plan?, isAdding: Bool, delegate: PlanDelegate) {
        self.navigationTitle = navigationTitle
        self.plan = plan
        self.isAdding = isAdding
        self.planDelegate = delegate
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setAddMode()
        setDetailMode(leftButton: configureNavigationEditBarButton(), isEditable: false)
    }

    private func configureView() {
        view.addSubview(planDetailView)

        planDetailView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        planDetailView.setTextViewDelegate(self)
    }

    private func setAddMode() {
        if isAdding {
            configureNavigationItem(leftButton: configureNavigationCancelBarButton(),
                                    rightButton: configureNavigationDoneBarButton())

            planDetailView.setPlaceholder()
        }
    }

    private func setDetailMode(leftButton: UIBarButtonItem, isEditable: Bool) {
        if isAdding == false {
            configureNavigationItem(leftButton: leftButton,
                                    rightButton: configureNavigationDoneBarButton())


            planDetailView.configureTextView(title: plan?.title ?? PlanText.emptyString,
                                             description: plan?.description ?? PlanText.emptyString,
                                             deadline: plan?.deadline ?? Date(),
                                             isEditable: isEditable)
        }
    }

    private func configureNavigationItem(leftButton: UIBarButtonItem, rightButton: UIBarButtonItem) {
        let navigationItem = UINavigationItem(title: navigationTitle)

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

        return UIBarButtonItem(systemItem: .cancel, primaryAction: buttonAction)
    }

    private func configureNavigationEditBarButton() -> UIBarButtonItem {
        let buttonAction = UIAction { [weak self] _ in
            self?.setDetailMode(leftButton: self?.configureNavigationCancelBarButton() ?? UIBarButtonItem(),
                                isEditable: true)
        }

        return UIBarButtonItem(systemItem: .edit, primaryAction: buttonAction)
    }

    private func configureNavigationDoneBarButton() -> UIBarButtonItem {
        let buttonAction = UIAction { [weak self] _ in
            if self?.isContentSave() == true {
                self?.dismiss(animated: true, completion: nil)
            }

            self?.present(self?.alertManager.showErrorAlert(title: Content.notSaving) ?? UIAlertController(), animated: true)
        }

        return UIBarButtonItem(systemItem: .done, primaryAction: buttonAction)
    }

    private func isContentSave() -> Bool? {
        let inputPlan = planDetailView.sendUserPlan()

        if plan?.validContent == true {
            save(title: inputPlan.title, description: inputPlan.description, deadline: inputPlan.deadline)
        }

        return plan?.validContent
    }

    func save(title: String, description: String, deadline: Date) {
        guard var plan = plan else { return }

        if planManager.isExistID(id: plan.id) == false {
            plan = planManager.create(title: title,
                          description: description,
                          deadline: deadline)

            planDelegate?.add(plan: plan)
        } else {
            plan.title = title
            plan.description = description
            plan.deadline = deadline
            
            planDelegate?.update(plan: plan)
        }
    }

    private enum Content {
        static let notSaving = "빈 내용은 저장되지 않습니다."
    }
}

extension PlanDetailViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        let isPlaceholder: Bool = textView.textColor == .systemGray3

        if isPlaceholder {
            textView.text = nil
            textView.textColor = .black
        }
    }
}
