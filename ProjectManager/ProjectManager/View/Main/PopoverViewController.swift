//
//  PopoverViewController.swift
//  ProjectManager
//
//  Created by Hyejeong Jeong on 2023/05/24.
//

import UIKit

final class PopoverViewController: UIViewController {
    let status: WorkStatus
    let viewModel: WorkViewModel
    
    private let topButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.backgroundColor = .white
        
        return button
    }()
    
    private let buttomButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.backgroundColor = .white
        
        return button
    }()
    
    init(status: WorkStatus, viewModel: WorkViewModel) {
        self.status = status
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
    }
    
    private func createStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [topButton, buttomButton])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        
        return stackView
    }
    
    private func configureLayout() {
        let stackView = createStackView()
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
