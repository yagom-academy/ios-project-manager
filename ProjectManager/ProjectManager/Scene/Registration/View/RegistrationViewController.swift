//
//  RegistrationViewController.swift
//  ProjectManager
//
//  Created by brad, bard. on 2022/09/11.
//

import UIKit

final class RegistrationViewController: UIViewController {
    
    // MARK: - Properties
    
    private let toDoComponentsView = ToDoComponentsView()
    private let registrationViewModel: RegistrationViewModel
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    init(with viewModel: RegistrationViewModel) {
        self.registrationViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.registrationViewModel = RegistrationViewModel(dataManager: FakeToDoItemManager())
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - Functions
    
    private func setupUI() {
        setupNavigationController()
        setupView()
        setupSubviews()
        setupConstraints()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupSubviews() {
        view.addSubview(toDoComponentsView)
        toDoComponentsView.setupEditable(is: true)
    }
    
    private func setupNavigationController() {
        navigationItem.title = Design.navigationTitle
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: Design.navigationTitleFontSize,
                                                           weight: .bold)
        ]
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.9488992095, green: 0.9492433667, blue: 0.9632378221, alpha: 1)
        
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                 target: self,
                                                 action: #selector(didDoneButtonTapped))
        let leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                target: self,
                                                action: #selector(didCancelButtonTapped))
        
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            toDoComponentsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            toDoComponentsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            toDoComponentsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            toDoComponentsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func dismissViewController() {
        navigationController?.dismiss(animated: true)
    }
    
    // MARK: - objc Functions
    
    @objc private func didDoneButtonTapped() {
        registrationViewModel.append(new: toDoComponentsView.fetchItem(), to: .todo)
        dismissViewController()
    }
    
    @objc private func didCancelButtonTapped() {
        dismissViewController()
    }
    
    // MARK: - Name Space
    
    private enum Design {
        static let navigationTitle = "TODO"
        static let navigationTitleFontSize: CGFloat = 20
    }
}
