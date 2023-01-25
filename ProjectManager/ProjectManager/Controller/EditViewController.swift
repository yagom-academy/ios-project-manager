//
//  EditViewController.swift
//  ProjectManager
//
//  Created by 서현웅 on 2023/01/18.
//

import UIKit

class EditViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var descriptionTextView: UITextView!
    var taskListVM: TaskListViewModel?
    var taskVM: TaskViewModel?
    var indexPathRow: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTask()
        setEditableMode(mode: false)
    }
    
    
    @IBAction func tapEdit(_ sender: UIBarButtonItem) {
        setEditableMode(mode: true)
    }
    
    @IBAction func tapDone(_ sender: UIBarButtonItem) {
        guard let indexPathRow = indexPathRow,
              let status = taskVM?.status else { return }
        
        let task = Task(title: titleTextField.text,
                        description: descriptionTextView.text,
                        date: datePicker.date,
                        status: status)
        taskListVM?.update(status: status,
                           newTask: task,
                           indexPathRow: indexPathRow)
        dismiss(animated: true)
    }
    
    private func setEditableMode(mode: Bool) {
        titleTextField.isUserInteractionEnabled = mode
        datePicker.isUserInteractionEnabled = mode
        descriptionTextView.isUserInteractionEnabled = mode
    }
    
    private func configureTask() {
        titleTextField.text = taskVM?.title
        datePicker.date = taskVM?.date ?? Date()
        descriptionTextView.text = taskVM?.description
    }
    
    func setUpTaskListVM(_ taskListViewModel: TaskListViewModel) {
        self.taskListVM = taskListViewModel
    }
    
    func setUpTaskVM(task: Task) {
        self.taskVM = TaskViewModel(task)
    }
}
