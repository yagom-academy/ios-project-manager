//
//  ListFormViewController.swift
//  ProjectManager
//  Created by inho on 2023/01/15.
//

import UIKit

class ListFormViewController: UIViewController {
    private let listFormView = ListFormView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureLayout()
    }
    
    private func configureNavigationBar() {
        navigationItem.leftBarButtonItem = .init(
            title: "Cancel",
            style: .plain,
            target: self,
            action: nil
        )
        navigationItem.title = "TODO"
        navigationItem.rightBarButtonItem = .init(
            title: "Done",
            style: .done,
            target: self,
            action: nil
        )
    }
    
    private func configureLayout() {
        view.backgroundColor = .white
        view.addSubview(listFormView)
        
        let safeArea = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            listFormView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            listFormView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            listFormView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            listFormView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}
