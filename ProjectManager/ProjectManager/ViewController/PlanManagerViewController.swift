//
//  ProjectManager - PlanManagerViewController.swift
//  Created by yagom.
//  Copyright © yagom. All rights reserved.
//

import UIKit
import Combine

final class PlanManagerViewController: UIViewController, SavingItemDelegate {
    private var cancellables = Set<AnyCancellable>()
    
    private let viewModel: PlanManagerViewModel
    private let todoPlanViewController: PlanViewController
    private let doingPlanViewController: PlanViewController
    private let donePlanViewController: PlanViewController

    init() {
        let todoViewModel = PlanViewModel(state: .todo)
        let doingViewModel = PlanViewModel(state: .doing)
        let doneViewModel = PlanViewModel(state: .done)
        
        viewModel = PlanManagerViewModel(todoViewModel: todoViewModel,
                                         doingViewModel: doingViewModel,
                                         doneViewModel: doneViewModel)
        
        todoPlanViewController = PlanViewController(headerName: State.todo.description, viewModel: todoViewModel)
        doingPlanViewController = PlanViewController(headerName: State.doing.description, viewModel: doingViewModel)
        donePlanViewController = PlanViewController(headerName: State.done.description, viewModel: doneViewModel)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let tableStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .systemGray4
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        setUpStackView()
        configureNavigationBar()
    }
    
    private func setUpView() {
        view.addSubview(tableStackView)
        view.backgroundColor = .white
        
        addChild(todoPlanViewController)
        todoPlanViewController.didMove(toParent: self)
        addChild(doingPlanViewController)
        doingPlanViewController.didMove(toParent: self)
        addChild(donePlanViewController)
        donePlanViewController.didMove(toParent: self)
    }
    
    private func setUpStackView() {
        tableStackView.addArrangedSubview(todoPlanViewController.view)
        tableStackView.addArrangedSubview(doingPlanViewController.view)
        tableStackView.addArrangedSubview(donePlanViewController.view)
        
        let safeArea = view.safeAreaLayoutGuide
        let bottom: CGFloat = -20
        tableStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableStackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: bottom),
            tableStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }
    
    private func configureNavigationBar() {
        let title = UILabel()
        title.text = "Project Manager"
        title.font = UIFont.preferredFont(forTextStyle: .title2)
        
        let plusButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonTapped))
        
        navigationItem.titleView = title
        navigationItem.rightBarButtonItem = plusButton
    }
    
    @objc private func plusButtonTapped() {
        let plusTodoViewModel = PlusTodoViewModel()
        let plusTodoViewController = PlusTodoViewController(plusTodoViewModel: plusTodoViewModel, mode: .create)
        plusTodoViewController.delegate = self
        
        present(plusTodoViewController, animated: false)
    }
    
    func create(_ item: Plan) {
        viewModel.create(item)
    }
    
    func update(by item: Plan) {
        viewModel.update(by: item)
    }
}
