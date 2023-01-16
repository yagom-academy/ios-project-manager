//
//  TodoViewController.swift
//  ProjectManager
//
//  Created by 애쉬 on 2023/01/16.
//

import UIKit

final class TodoViewController: UIViewController {
    override func loadView() {
        self.view = TodoView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .systemGray6
        navigationItem.title = "TODO"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(tappedCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(tappedDone))
        
    }
    
    @objc private func tappedCancel() {
        dismiss(animated: true)
    }
    
    @objc private func tappedDone() {
        dismiss(animated: true)
    }
}
