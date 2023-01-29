//
//  MainViewController.swift
//  ProjectManager
//
//  Created by summercat on 2023/01/12.
//

import UIKit

final class MainViewController: UIViewController {
    private enum Constant {
        enum Namespace {
            static let navigationTitle = "Project Manager"
            static let plusImage = "plus"
        }
        
        enum LayoutConstant {
            static let mainStackViewMargin = CGFloat(8)
            static let columnSpacing = CGFloat(16)
        }
    }
    
    private lazy var todoListViewController = IssueListViewController(status: .todo, delegate: self)
    private lazy var doingListViewController = IssueListViewController(status: .doing, delegate: self)
    private lazy var doneListViewController = IssueListViewController(status: .done, delegate: self)
    
    private var mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = Constant.LayoutConstant.columnSpacing
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: Constant.LayoutConstant.mainStackViewMargin,
            leading: Constant.LayoutConstant.mainStackViewMargin,
            bottom: Constant.LayoutConstant.mainStackViewMargin,
            trailing: Constant.LayoutConstant.mainStackViewMargin
        )
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        configureNavigationBar()
        configureMainStackView()
        configureChildViewControllers()
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        title = Constant.Namespace.navigationTitle
        let plusButton = UIBarButtonItem(
            image: UIImage(systemName: Constant.Namespace.plusImage),
            primaryAction: UIAction { _ in
                let issueViewcontroller = IssueViewController(delegate: self.todoListViewController)
                let navigationViewController = UINavigationController(rootViewController: issueViewcontroller)
                self.present(navigationViewController, animated: true)
            })
        navigationItem.rightBarButtonItem = plusButton
    }
    
    private func configureMainStackView() {
        view.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func configureChildViewControllers() {
        [todoListViewController, doingListViewController, doneListViewController].forEach {
            addChild($0)
            mainStackView.addArrangedSubview($0.view)
            $0.didMove(toParent: self)
        }
    }
}

extension MainViewController: IssueListDelegate {
    func shouldDeliver(issue: Issue) {
        switch issue.status {
        case .todo:
            todoListViewController.shouldAdd(issue: issue)
        case .doing:
            doingListViewController.shouldAdd(issue: issue)
        case .done:
            doneListViewController.shouldAdd(issue: issue)
        }
    }
}
