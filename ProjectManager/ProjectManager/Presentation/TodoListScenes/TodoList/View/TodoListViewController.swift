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
    private unowned let factory: TodoListSceneFactory
    
    private var cancelBag = Set<AnyCancellable>()
    
    init(viewModel: TodoListViewModelable, factory: TodoListSceneFactory) {
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
            .store(in: &cancelBag)
        
        viewModel.errorOccur
            .sink { [weak self] result in
                switch result {
                case .success(let success):
                    print(success)
                case .failure(let error):
                    self?.showAlert(title: error.localizedDescription)
                }
            }
            .store(in: &cancelBag)
        
        viewModel.isNetworkConnected
            .receive(on: DispatchQueue.main)
            .sink { [weak self] status in
                self?.todoListView.networkStatusImageView.image = UIImage(systemName: status)
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
            
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "History", image: nil, primaryAction: showHistory)
        
        let addAction = UIAction { [weak self] _ in
            self?.viewModel.didTapAddButton()
        }

        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: addAction)
    }
}

extension UIViewController {
    func showAlert(title: String, message: String? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { _ in
            
        }
        alertController.addAction(confirmAction)
        
        self.present(alertController, animated: true)
    }
}
