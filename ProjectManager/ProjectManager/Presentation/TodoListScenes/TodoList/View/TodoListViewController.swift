//
//  TodoListViewController.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import UIKit
import Combine

import SnapKit

final class TodoListViewController: UIViewController {
    private lazy var todoListView = factory.makeTodoListView()
    private let viewModel: TodoListViewModelable
    private unowned let factory: ViewControllerFactory
    
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: TodoListViewModelable, factory: ViewControllerFactory) {
        self.viewModel = viewModel
        self.factory = factory
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubviews()
        setupConstraint()
        setupView()
        bind()
    }
    
    private func bind() {
        viewModel.title
            .sink { [weak self] title in
                self?.title = title
            }
            .store(in: &cancellables)
    }
    
    private func addSubviews() {
        view.addSubview(todoListView)
    }
    
    private func setupConstraint() {
        todoListView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        
        let addAction = UIAction { [weak self] _ in
            self?.viewModel.didTapAddButton()
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: addAction)
    }
}
