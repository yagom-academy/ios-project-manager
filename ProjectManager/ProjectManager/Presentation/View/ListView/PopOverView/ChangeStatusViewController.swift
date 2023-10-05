//
//  PopOverViewController.swift
//  ProjectManager
//
//  Created by Min Hyun on 2023/10/06.
//

import UIKit

class ChangeStatusViewController: UIViewController {
    let entity: ToDo
    let currentStatus: ToDoStatus
    let viewModel: ToDoChangeStatusViewModelType
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    init(_ entity: ToDo, status: ToDoStatus, viewModel: ToDoChangeStatusViewModelType) {
        self.entity = entity
        self.viewModel = viewModel
        currentStatus = status
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        makeButtons()
    }
    
    func setupUI() {
        let safeArea = view.safeAreaLayoutGuide
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, constant: -30),
            stackView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, constant: -30),
            stackView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
        ])
    }
    
    func makeButtons() {
        ToDoStatus.allCases.filter({ $0 != currentStatus }).forEach { status in
            let button = ChangeStatusButton(status: status)
            button.addTarget(self, action: #selector(moveStatus(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
    }
    
    @objc func moveStatus(_ sender: ChangeStatusButton) throws {
        viewModel.inputs.touchUpButton(entity, status: sender.status)
        self.dismiss(animated: true)
    }
}
