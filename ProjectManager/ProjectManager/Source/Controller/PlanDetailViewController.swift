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
    private let changedPlan: (Plan?) -> Void
    private let planManager = PlanManager()
    private let alertManager = AlertManager()
    private var delegate: AlertDelegate

    init(navigationTitle: String, plan: Plan?, isAdding: Bool, delegate: AlertDelegate, changedPlan: @escaping (Plan?) -> Void) {
        self.navigationTitle = navigationTitle
        self.plan = plan
        self.isAdding = isAdding
        self.delegate = delegate
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


            planDetailView.configureTextView(title: plan?.title ?? Content.emptyString,
                                             description: plan?.description ?? Content.emptyString,
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

        let button = UIBarButtonItem(systemItem: .cancel, primaryAction: buttonAction)

        return button
    }

    private func configureNavigationEditBarButton() -> UIBarButtonItem {
        let buttonAction = UIAction { [weak self] _ in
            self?.setDetailMode(leftButton: self?.configureNavigationCancelBarButton() ?? UIBarButtonItem(),
                                isEditable: true)
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

        do {
            try planManager.save(title: inputPlan.title,
                             description: inputPlan.description,
                             deadline: inputPlan.deadline,
                             plan: &plan)
        } catch {
            delegate.showErrorAlert(title: Content.notSaving)
        }
    }

    private enum Content {
        static let notSaving = "빈 내용은 저장되지 않습니다."
        static let emptyString = ""
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
