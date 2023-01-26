//
//  EditProjectViewController.swift
//  ProjectManager
//
//  Created by jin on 1/26/23.
//

import UIKit

protocol TaskEditDelegate: AnyObject {
    func taskDidEdited(to newTask: Task, from task: Task)
}

class EditProjectViewController: AddProjectViewController {

    private var task: Task
    var editDelegate: TaskEditDelegate?
    
    init(task: Task) {
        self.task = task
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskSettingView.configureTaskData(with: task)
    }
    
    override func configureNavigationItem() {
        navigationItem.title = task.status.rawValue
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editAndDismissViewController))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissCurrentViewController))
    }
    
    @objc private func editAndDismissViewController() {
        let newTask = taskSettingView.fetchTask()
        if let newTask {
            self.editDelegate?.taskDidEdited(to: newTask, from: task)
        }
        dismissCurrentViewController()
    }
}
