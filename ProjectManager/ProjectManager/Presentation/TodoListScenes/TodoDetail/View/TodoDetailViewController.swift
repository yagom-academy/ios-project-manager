//
//  TodoDetailViewController.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import UIKit

final class TodoDetailViewController: UIViewController {
    
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
        
        let cancelAction = UIAction { [weak self] _ in
            self?.viewModel.closeButtonDidTap()
        }
        
        let doneAction = UIAction { [weak self] _ in
            guard let title = self?.todoDetailView.titleTextField.text,
                  let content = self?.todoDetailView.contentTextView.text,
                  let deadLine = self?.todoDetailView.datePicker.date
            else {
                return
            }
            self?.viewModel.doneButtonDidTap(title: title, content: content, deadLine: deadLine)
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .cancel, primaryAction: cancelAction)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .done, primaryAction: doneAction)
    }
}
