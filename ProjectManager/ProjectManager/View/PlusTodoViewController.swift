//
//  PlusTodoViewController.swift
//  ProjectManager
//
//  Created by 리지 on 2023/05/17.
//

import UIKit

final class PlusTodoViewController: UIViewController, TodoViewDelegate {
    
    private let todoView: TodoView
    private let todoViewModel: TodoViewModel
    
    init(todoView: TodoView, todoViewModel: TodoViewModel) {
        self.todoView = todoView
        self.todoViewModel = todoViewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
    }
    
    private func setUpView() {
        view.addSubview(todoView)
        todoViewModel.delegate = self
        
        todoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            todoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            todoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            todoView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            todoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
    
    func dismiss() {
        self.dismiss(animated: true)
    }
}
