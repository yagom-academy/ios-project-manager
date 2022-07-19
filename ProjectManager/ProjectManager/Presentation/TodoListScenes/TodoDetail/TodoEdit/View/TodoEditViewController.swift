//
//  TodoEditViewController.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import UIKit
import Combine

final class TodoEditViewController: UIViewController {
    private var cancelBag = Set<AnyCancellable>()
    private let viewModel: TodoEditViewModelable
    private let todoDetailView = TodoDetailView()
    
    weak var coordiantor: TodoDetailViewCoordinator?

    init(viewModel: TodoEditViewModelable) {
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
        self.coordiantor?.dismiss()
    }
    
    private func bind() {
        viewModel.item
            .sink { [weak self] item in
                self?.todoDetailView.titleTextField.text = item.title
                self?.todoDetailView.datePicker.date = item.deadline
                self?.todoDetailView.contentTextView.text = item.content
            }
            .store(in: &cancelBag)
        
        viewModel.title
            .sink { [weak self] title in
                self?.title = title
            }
            .store(in: &cancelBag)
        
        viewModel.dismissView
            .sink { [weak self] _  in
                self?.coordiantor?.dismiss()
            }
            .store(in: &cancelBag)
        
        viewModel.isEdited
            .sink { [weak self] _ in
                self?.setupNavigationLeftBarButtonItem()
                self?.todoDetailView.setupUserInteractionEnabled(true)
            }
            .store(in: &cancelBag)
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
        todoDetailView.setupUserInteractionEnabled(false)
        
        view.backgroundColor = .systemBackground
        
        let editAction = UIAction { [weak self] _ in
            self?.viewModel.didTapEditButton()
        }
                
        let doneAction = UIAction { [weak self] _ in
            self?.viewModel.didTapDoneButton(
                title: self?.todoDetailView.titleTextField.text,
                content: self?.todoDetailView.contentTextView.text,
                deadline: self?.todoDetailView.datePicker.date
            )
            
            self?.coordiantor?.dismiss()
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            systemItem: .edit,
            primaryAction: editAction
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .done, primaryAction: doneAction)
    }
    
    private func setupNavigationLeftBarButtonItem() {
        let cancelAction = UIAction { [weak self] _ in
            self?.coordiantor?.dismiss()
        }
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            systemItem: .cancel,
            primaryAction: cancelAction
        )
    }
}
