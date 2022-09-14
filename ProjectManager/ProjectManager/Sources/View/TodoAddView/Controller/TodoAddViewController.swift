//
//  TodoAddViewController.swift
//  ProjectManager
//
//  Created by 유한석 on 2022/09/12.
//

import UIKit

class TodoAddViewController: UIViewController {
    
    //MARK: - UI Properties
    var state: ProjetTaskState?
    private lazy var todoAddView = TodoAddView(frame: .zero)
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupTodoAddView()
        setupNavigationBarItem()
    }
}

private extension TodoAddViewController {
    
    //MARK: - Root View Setup
    func setupTodoAddView() {
        todoAddView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(todoAddView)
        NSLayoutConstraint.activate([
            todoAddView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            todoAddView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            todoAddView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            todoAddView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func setupNavigationBarItem() {
        navigationItem.title = state?.rawValue
        view.backgroundColor = .systemGray5
        setupRightBarButtonItem()
        setupLeftBarButtonItem()
    }
    
    func setupRightBarButtonItem() {
        let rightBarButtonItem = UIBarButtonItem(systemItem: .done)
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func setupLeftBarButtonItem() {
        var leftBarButtonItem: UIBarButtonItem
        switch state {
        case .TODO:
            leftBarButtonItem = UIBarButtonItem(systemItem: .cancel)
        case .DOING:
            leftBarButtonItem = UIBarButtonItem(systemItem: .edit)
        case .DONE:
            leftBarButtonItem = UIBarButtonItem(systemItem: .edit)
        default:
            leftBarButtonItem = UIBarButtonItem(systemItem: .cancel)
        }
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
}
