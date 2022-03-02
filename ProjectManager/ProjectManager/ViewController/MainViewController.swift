//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class MainViewController: UIViewController {
    let taskStackView = UIStackView()
    let toDoViewController = ToDoViewController()
    let doingViewController = DoingViewController()
    let doneViewController = DoneViewController()
    
    var toDoView: UIView!
    var doingView: UIView!
    var doneView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainView()
        setupTaskStackView()
        setupConstraint()
    }
    
    func setupMainView() {
        self.addChild(toDoViewController)
        self.addChild(doingViewController)
        self.addChild(doneViewController)
        
        self.toDoView = toDoViewController.view
        self.doingView = doingViewController.view
        self.doneView = doneViewController.view
        
        self.view.addSubview(taskStackView)

    }
    
    func setupTaskStackView() {
        taskStackView.addArrangedSubview(toDoView)
        taskStackView.addArrangedSubview(doingView)
        taskStackView.addArrangedSubview(doneView)
        
        taskStackView.axis = .horizontal
        taskStackView.distribution = .fillEqually
    }
    
    func setupConstraint() {
        taskStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            taskStackView.topAnchor.constraint(equalTo: view.topAnchor),
            taskStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            taskStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            taskStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

    }
    

    

}

