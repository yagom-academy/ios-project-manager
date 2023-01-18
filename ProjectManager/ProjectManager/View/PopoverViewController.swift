//
//  PopoverViewController.swift
//  ProjectManager
//
//  Created by Baem on 2023/01/18.
//

import UIKit

final class PopoverViewController: UIViewController {
    let topButton: UIButton = {
        let button = UIButton()
        button.setTitle("Move To DOING", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        
        return button
    }()
    
    let bottomButton: UIButton = {
        let button = UIButton()
        button.setTitle("Move To DONE", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray6
        
        configureLayout()
    }
    
    private func configureLayout() {
        self.view.addSubview(stackView)
        [topButton, bottomButton].forEach(stackView.addArrangedSubview(_:))
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
