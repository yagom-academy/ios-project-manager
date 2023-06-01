//
//  MainViewController.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/17.
//

import UIKit
import Combine

final class MainViewController: UIViewController {
    private let todoViewController = TaskListViewController(state: .todo)
    private let doingViewController = TaskListViewController(state: .doing)
    private let doneViewController = TaskListViewController(state: .done)
    
    private let viewModel = MainViewModel()
    private var subscriptions = Set<AnyCancellable>()
    
    private let mainStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .systemGray3
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        bindAddButton()
    }
    
    private func setupView() {
        view.addSubview(mainStackView)
        view.backgroundColor = .systemGray5
        
        setupNavigationBar()
        addChildViews()
        addSubViews()
        setupMainStackViewConstraints()
    }
    
    private func setupNavigationBar() {
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .add,
                                            target: self,
                                            action: #selector(addTask))
        
        let leftBarButtonTittle = "History"
        let leftBarButton = UIBarButtonItem(title: leftBarButtonTittle,
                                            style: .plain,
                                            target: self,
                                            action: #selector(showHistory(sender:)))
        
        let projectTitle = "Project Manager"
        
        navigationItem.title = projectTitle
        navigationItem.rightBarButtonItem = rightBarButton
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
    @objc private func addTask() {
        let taskFormViewController = TaskFormViewController()
        let navigationController = UINavigationController(rootViewController: taskFormViewController)
        
        present(navigationController, animated: true)
    }
    
    @objc private func showHistory(sender: UIBarButtonItem) {
        guard let barButton = sender.value(forKey: "view") as? UIView else { return }
        
        let historyViewController = HistoryViewController()
        historyViewController.modalPresentationStyle = .popover
        historyViewController.preferredContentSize = CGSize(width: view.frame.width * 0.4,
                                                            height: view.frame.height * 0.53)
        
        let popoverController = historyViewController.popoverPresentationController
        popoverController?.sourceView = view
        popoverController?.sourceRect = CGRect(x: barButton.frame.midX,
                                               y: barButton.frame.midY,
                                               width: barButton.frame.width,
                                               height: barButton.frame.height)
        popoverController?.permittedArrowDirections = .up
        
        present(historyViewController, animated: true)
    }
    
    private func bindAddButton() {
        viewModel.isNetworkConnectedPublisher()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.navigationItem.rightBarButtonItem?.isEnabled = $0
            }
            .store(in: &subscriptions)
    }
    
    private func addChildViews() {
        addChild(todoViewController)
        addChild(doingViewController)
        addChild(doneViewController)
    }
    
    private func addSubViews() {
        mainStackView.addArrangedSubview(todoViewController.view)
        mainStackView.addArrangedSubview(doingViewController.view)
        mainStackView.addArrangedSubview(doneViewController.view)
    }
    
    private func setupMainStackViewConstraints() {
        let safe = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: safe.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: safe.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -safe.layoutFrame.height * 0.05)
        ])
    }
}
