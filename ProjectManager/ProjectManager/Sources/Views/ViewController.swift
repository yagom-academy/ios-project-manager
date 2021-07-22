//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {

    let pmStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setSubView()
        pmStackView.addArrangedSubview(StateStackView(state: .todo))
        pmStackView.addArrangedSubview(StateStackView(state: .doing))
        pmStackView.addArrangedSubview(StateStackView(state: .done))
    }

    private func setSubView() {
        view.addSubview(pmStackView)
        NSLayoutConstraint.activate([
            pmStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pmStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pmStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pmStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
