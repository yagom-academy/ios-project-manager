//
//  ProjectManager - MainViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class MainViewController: UIViewController {
    private enum Constant {
        case navigationTitle
        
        var description: String {
            switch self {
            case .navigationTitle:
                return "Project Manager"
            }
        }
    }
    
    private let todoStackView = ProcessStackView(process: .todo)
    private let doingStackView = ProcessStackView(process: .doing)
    private let doneStackView = ProcessStackView(process: .done)
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [todoStackView, doingStackView, doneStackView]
        )
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupView()
    }
    
    @objc private func addButtonTapped() {
        // 추후 구현
    }
}

// MARK: - UI Configuration
extension MainViewController {
    private func setupNavigationBar() {
        title = Constant.navigationTitle.description
        let appearence = UINavigationBarAppearance()
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = .systemGray6
        navigationController?.navigationBar.standardAppearance = appearence
        navigationController?.navigationBar.scrollEdgeAppearance = appearence
        
        let addBarButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonTapped)
        )
        navigationItem.rightBarButtonItem = addBarButton
    }
    
    private func setupView() {
        view.backgroundColor = .systemGray5
        view.addSubview(mainStackView)
    }
}
