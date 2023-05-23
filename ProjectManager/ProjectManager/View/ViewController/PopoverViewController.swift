//
//  PopoverViewController.swift
//  ProjectManager
//
//  Created by 리지 on 2023/05/22.
//

import UIKit

final class PopoverViewController: UIViewController {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .systemGray5
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private let firstButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Move To", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title3)

        return button
    }()
    
    private let secondButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Move To", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpPopover()
        setUpStackView()
    }
    
    private func setUpPopover() {
        view.backgroundColor = .systemGray5
        view.addSubview(stackView)
        preferredContentSize = CGSize(width: 300, height: 150)
    }
    
    private func setUpStackView() {
        stackView.addArrangedSubview(firstButton)
        stackView.addArrangedSubview(secondButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
}
