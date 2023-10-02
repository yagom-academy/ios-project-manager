//
//  ProjectManager - MainViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class MainViewController: UIViewController {
    private let todoView: WorkView
    private let doingView: WorkView
    private let doneView: WorkView
    
    init() {
        self.todoView = WorkView(workType: .todo)
        self.doingView = WorkView(workType: .doing)
        self.doneView = WorkView(workType: .done)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationItem()
        setUI()
    }
    
    private func setNavigationItem() {
        navigationItem.title = "Project Manager"
        
        let addAction = UIAction { _ in
            // TODO: + 버튼 터치 시 동작 작성
            
            print("touch addAction")
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: addAction)
    }

    private func setUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(todoView)
        mainStackView.addArrangedSubview(doingView)
        mainStackView.addArrangedSubview(doneView)
        
        mainStackView.backgroundColor = .systemGray4
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
