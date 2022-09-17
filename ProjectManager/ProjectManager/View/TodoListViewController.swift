//
//  ProjectManager - TodoListViewController.swift
//  Created by bonf.
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import RxSwift

final class TodoListViewController: UIViewController {
    
    // MARK: - properties
    
    private var todoView = ListView(status: .todo)
    private var doingView = ListView(status: .doing)
    private var doneView = ListView(status: .done)
    
    private var viewModel = ViewModel()
    
    private var disposeBag = DisposeBag()
    
    private let listStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 8
        
        return stackView
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        setupListStackView()
        todoView.viewModel = viewModel
        doingView.viewModel = viewModel
        doneView.viewModel = viewModel
        
        setupListsCellTouchEvent()
    }
}

// MARK: - functions

extension TodoListViewController {
    private func setupListStackView() {
        view.backgroundColor = .systemGray6
        
        view.addSubview(listStackView)
        listStackView.addArrangedSubview(todoView)
        listStackView.addArrangedSubview(doingView)
        listStackView.addArrangedSubview(doneView)
        
        NSLayoutConstraint.activate([
            listStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            listStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            listStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            listStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func setupNavigationItem() {
        navigationItem.title = Design.navigationItemTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(showAlert))
    }
    
    private func setupListsCellTouchEvent() {
        todoView.tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.todoView.tableView.deselectRow(at: indexPath, animated: true)
                print(indexPath.row)
                let projectViewController = ProjectViewController()
                projectViewController.modalPresentationStyle = .formSheet
                let projectAddViewController = UINavigationController(rootViewController: projectViewController)
                self?.present(projectAddViewController, animated: true)
            })
            .disposed(by: disposeBag)
        
        doingView.tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.todoView.tableView.deselectRow(at: indexPath, animated: true)
                print(indexPath.row)
                let projectViewController = ProjectViewController()
                projectViewController.modalPresentationStyle = .formSheet
                let projectAddViewController = UINavigationController(rootViewController: projectViewController)
                self?.present(projectAddViewController, animated: true)
            })
            .disposed(by: disposeBag)
        
        doneView.tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.todoView.tableView.deselectRow(at: indexPath, animated: true)
                print(indexPath.row)
                let projectViewController = ProjectViewController()
                projectViewController.modalPresentationStyle = .formSheet
                let projectAddViewController = UINavigationController(rootViewController: projectViewController)
                projectViewController.navigationItem.leftBarButtonItem?.
                self?.present(projectAddViewController, animated: true)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - objc functions

extension TodoListViewController {
    @objc private func showAlert() {
        let projectViewController = ProjectViewController()
        projectViewController.viewModel = viewModel
        projectViewController.modalPresentationStyle = .formSheet
        let projectAddViewController = UINavigationController(rootViewController: projectViewController)
        present(projectAddViewController, animated: true)
    }
}

private enum Design {
    static let navigationItemTitle = "Project Manager"
}
