//
//  MovePopoverViewController.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/29.
//

import UIKit

final class MovePopoverViewController: UIViewController {
    private let stackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let firstButton = {
        let button = UIButton()
        
        return button
    }()
    
    private let secondButton = {
        let button = UIButton()
        
        return button
    }()
    
    private let viewModel: MovePopoverViewModel
    
    init(viewModel: MovePopoverViewModel) {
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        configureLayout()
    }
    
    private func configureLayout() {
        stackView.addArrangedSubview(firstButton)
        stackView.addArrangedSubview(secondButton)
        
        let safe = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safe.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: safe.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: safe.bottomAnchor)
        ])
    }
}
