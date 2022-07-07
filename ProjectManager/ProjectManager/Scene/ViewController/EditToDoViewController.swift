//
//  EditToDoViewController.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/07.
//

import UIKit

final class EditToDoViewController: UIViewController {
    
    private let editToDoView = NewToDoView()
    var task: Task?

    override func loadView() {
        super.loadView()
        view = editToDoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBarItems()
        setupContents()
    }
    
    private func configureNavigationBarItems() {
        title = task?.taskType.value
        
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .plain,
            target: self,
            action: #selector(doneButtonTapped)
        )
        navigationItem.rightBarButtonItem = doneButton
        
        let editButton = UIBarButtonItem(
            title: "Edit",
            style: .plain,
            target: self,
            action: #selector(editButtonTapped)
        )
        navigationItem.leftBarButtonItem = editButton
    }
    
    @objc private func editButtonTapped() {
        // 저장 기능
        dismiss(animated: true)
    }
    
    @objc private func doneButtonTapped() {
        dismiss(animated: true)
    }
    
    private func setupContents() {
        if let task = task {
            editToDoView.setUpContents(task: task)
        }
    }
}
