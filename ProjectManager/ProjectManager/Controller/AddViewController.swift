//
//  AddViewController.swift
//  ProjectManager
//
//  Created by 서현웅 on 2023/01/16.
//

import UIKit

class AddViewController: UIViewController {
    @IBOutlet weak var titleTextFiled: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var descriptionTextView: UITextView!
    var taskListVM: TaskListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tapDone(_ sender: UIBarButtonItem) {
        guard let titleTextFiled = titleTextFiled,
              let descriptionTextView = descriptionTextView else { return }
        
        let task = Task(title: titleTextFiled.text,
                        description: descriptionTextView.text,
                        date: datePicker.date,
                        status: .todo)
        taskListVM?.create(task: task)
        dismiss(animated: true)
    }
    
    func setUpTaskListVM(_ taskListVM: TaskListViewModel) {
        self.taskListVM = taskListVM
    }
}
