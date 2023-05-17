//
//  PlusTodoViewController.swift
//  ProjectManager
//
//  Created by 리지 on 2023/05/17.
//

import UIKit

final class PlusTodoViewController: UIViewController, TodoViewDelegate {
    
    private let todoView: TodoView = TodoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
    }
    
    private func setUpView() {
        view.addSubview(todoView)
        todoView.delegate = self 
        
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
