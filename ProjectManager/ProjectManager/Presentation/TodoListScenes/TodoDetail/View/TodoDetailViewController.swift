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
    private let viewModel: TodoDetailViewModel
    private lazy var todoDetailView = TodoDetailView(frame: self.view.bounds)

    init(viewModel: TodoDetailViewModel) {
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
    
    private func bind() {
        viewModel.item
            .sink { [weak self] item in
                self?.todoDetailView.titleTextField.text = item.title
                self?.todoDetailView.datePicker.date = item.deadLine ?? Date()
                self?.todoDetailView.contentTextView.text = item.content
            }
            .store(in: &cancellables)
        
        viewModel.isCreate
            .sink { [weak self] state in
                self?.todoDetailView.setupUserInteractionEnabled(state)
                self?.setupNavigationLeftBarButtonItem(state)
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
        title = "TODO"

        let doneAction = UIAction { [weak self] _ in
            guard let title = self?.todoDetailView.titleTextField.text,
                  let content = self?.todoDetailView.contentTextView.text,
                  let deadLine = self?.todoDetailView.datePicker.date
            else {
                return
            }
            self?.viewModel.doneButtonDidTap(title: title, content: content, deadLine: deadLine)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .done, primaryAction: doneAction)
    }
    
    private func setupNavigationLeftBarButtonItem(_ state: Bool) {
        if state {
            let cancelAction = UIAction { [weak self] _ in
                self?.viewModel.closeButtonDidTap()
            }
            
            navigationItem.leftBarButtonItem = UIBarButtonItem(
                systemItem: .cancel,
                primaryAction: cancelAction
            )
        } else {
            let editAction = UIAction { [weak self] _ in
                self?.viewModel.editButtonDidTap()
            }
            
            navigationItem.leftBarButtonItem = UIBarButtonItem(
                systemItem: .edit,
                primaryAction: editAction
            )
        }
    }
}
