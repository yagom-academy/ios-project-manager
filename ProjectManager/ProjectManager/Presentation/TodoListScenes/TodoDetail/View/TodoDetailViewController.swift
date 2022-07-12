//
//  TodoDetailViewController.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import UIKit
import Combine

final class TodoDetailViewController: UIViewController {
    
    private var cancellables = Set<AnyCancellable>()
    private let viewModel: TodoDetailViewModelable
    private let todoDetailView = TodoDetailView()

    init(viewModel: TodoDetailViewModelable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bind()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        viewModel.viewDidDisapper()
    }
    
    private func bind() {
        viewModel.item
            .sink { [weak self] item in
                self?.todoDetailView.titleTextField.text = item.title
                self?.todoDetailView.datePicker.date = item.deadLine
                self?.todoDetailView.contentTextView.text = item.content
            }
            .store(in: &cancellables)
        
        viewModel.isCreate
            .sink { [weak self] state in
                self?.todoDetailView.setupUserInteractionEnabled(state)
                self?.setupNavigationLeftBarButtonItem(state)
            }
            .store(in: &cancellables)
        
        viewModel.title
            .sink { [weak self] title in
                self?.title = title
            }
            .store(in: &cancellables)
    }
    
    private func setup() {
        addSubviews()
        setupConstraint()
        setupView()
    }
    
    private func addSubviews() {
        view.addSubview(todoDetailView)
    }
    
    private func setupConstraint() {
        todoDetailView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        
        let doneAction = UIAction { [weak self] _ in
            self?.viewModel.didTapDoneButton(
                title: self?.todoDetailView.titleTextField.text,
                content: self?.todoDetailView.contentTextView.text,
                deadLine: self?.todoDetailView.datePicker.date
            )
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .done, primaryAction: doneAction)
    }
    
    private func setupNavigationLeftBarButtonItem(_ state: Bool) {
        if state {
            let cancelAction = UIAction { [weak self] _ in
                self?.viewModel.didTapCloseButton()
            }
            
            navigationItem.leftBarButtonItem = UIBarButtonItem(
                systemItem: .cancel,
                primaryAction: cancelAction
            )
        } else {
            let editAction = UIAction { [weak self] _ in
                self?.viewModel.didTapEditButton()
            }
            
            navigationItem.leftBarButtonItem = UIBarButtonItem(
                systemItem: .edit,
                primaryAction: editAction
            )
        }
    }
}
