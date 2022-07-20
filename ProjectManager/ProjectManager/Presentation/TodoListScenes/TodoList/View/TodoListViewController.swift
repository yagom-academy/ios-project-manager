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
    private unowned let factory: TodoSceneFactory
    weak var coordinator: TodoListViewCoordinator?
    private lazy var todoListView = factory.makeTodoListView()
    private let viewModel: TodoListViewModelable
    
    private var cancelBag = Set<AnyCancellable>()
    
    init(viewModel: TodoListViewModelable, factory: TodoSceneFactory) {
        self.viewModel = viewModel
        self.factory = factory
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
        viewModel.title
            .sink { [weak self] title in
                self?.title = title
            }
            .store(in: &cancelBag)
        
        viewModel.showErrorAlert
            .sink { [weak self] errorMessage in
                self?.showErrorAlertWithConfirmButton(errorMessage)
            }
            .store(in: &cancelBag)
        
        viewModel.isNetworkConnected
            .receive(on: DispatchQueue.main)
            .sink { [weak self] status in
                self?.todoListView.networkStatusImageView.image = UIImage(systemName: status)
            }
            .store(in: &cancelBag)
        
        viewModel.showCreateView
            .sink { [weak self] _ in
                self?.coordinator?.showCreateViewController()
            }
            .store(in: &cancelBag)
        
        viewModel.showEditView
            .sink { [weak self] item in
                self?.coordinator?.showDetailViewController(item)
            }
            .store(in: &cancelBag)
        
        viewModel.showHistoryView
            .sink { [weak self] _ in
                self?.coordinator?.showHistoryViewController(sourceView: self!.navigationItem.leftBarButtonItem!)
            }
            .store(in: &cancelBag)
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
