//
//  TodoListViewController.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import UIKit
import Combine

import SnapKit

final class TodoListViewController: UIViewController, Alertable {
    private unowned let dependency: TodoListDIContainer
    weak var coordinator: TodoListViewCoordinator?
    private lazy var todoListView = dependency.makeTodoListView()
    private let viewModel: TodoListViewModelable
    
    private var cancellableBag = Set<AnyCancellable>()
    
    init(viewModel: TodoListViewModelable, dependency: TodoListDIContainer) {
        self.viewModel = viewModel
        self.dependency = dependency
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel.viewDidLoad()
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
        viewModel.state
            .sink { [weak self] state in
                switch state {
                case .viewTitleEvent(let title):
                    self?.title = title
                case .errorEvent(let message):
                    self?.showErrorAlertWithConfirmButton(message)
                case .showEditViewEvent(let item):
                    self?.coordinator?.showDetailViewController(item)
                case .showHistoryViewEvent:
                    guard let sourceView = self?.navigationItem.leftBarButtonItem else {
                        return
                    }
                    self?.coordinator?.showHistoryViewController(sourceView: sourceView)
                case .showCreateViewEvent:
                    self?.coordinator?.showCreateViewController()
                }
            }
            .store(in: &cancellableBag)
        
        viewModel.isNetworkConnected
            .receive(on: DispatchQueue.main)
            .sink { [weak self] status in
                self?.todoListView.networkStatusImageView.image = UIImage(systemName: status)
            }
            .store(in: &cancellableBag)
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
        
        let showHistory = UIAction { [weak self] _ in
            self?.viewModel.didTapHistoryButton()
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "History", image: nil, primaryAction: showHistory)
        
        let addAction = UIAction { [weak self] _ in
            self?.viewModel.didTapAddButton()
        }

        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: addAction)
    }
}
