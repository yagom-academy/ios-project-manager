//
//  TodoCreateViewController.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/19.
//

import UIKit
import Combine

import SnapKit

final class TodoCreateViewController: UIViewController, Alertable {
    private let viewModel: TodoCreateViewModelable
    private var cancelBag = Set<AnyCancellable>()
    private let todoCreateView = TodoDetailView()
    
    weak var coordinator: TodoCreateViewCoordinator?
    
    init(viewModel: TodoCreateViewModelable) {
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
        viewModel.dismissView
            .sink { [weak self] in
                self?.coordinator?.dismiss()
            }
            .store(in: &cancelBag)
        
        viewModel.showErrorAlert
            .sink { [weak self] errorMessage in
                self?.showErrorAlertWithConfirmButton(errorMessage)
            }
            .store(in: &cancelBag)
    }
    
    private func setup() {
        addSubviews()
        setupConstraint()
        setupView()
    }
    
    private func addSubviews() {
        view.addSubview(todoCreateView)
    }
    
    private func setupConstraint() {
        todoCreateView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        
        let cancelButton = UIAction { [weak self] _ in
            self?.viewModel.didTapCancelButton()
        }
                
        let doneAction = UIAction { [weak self] _ in
            self?.viewModel.didTapDoneButton(
                self?.todoCreateView.titleTextField.text,
                self?.todoCreateView.contentTextView.text,
                self?.todoCreateView.datePicker.date
            )
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            systemItem: .cancel,
            primaryAction: cancelButton
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .done, primaryAction: doneAction)
    }
}
