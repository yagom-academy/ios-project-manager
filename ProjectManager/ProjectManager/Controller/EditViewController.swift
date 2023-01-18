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
    var indexPathRow: Int?
    var status: Status?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSelectedTask()
        setEditableMode(mode: false)
    }
    
    
    @IBAction func tapEdit(_ sender: UIBarButtonItem) {
        setEditableMode(mode: true)
    }
    
    @IBAction func tapDone(_ sender: UIBarButtonItem) {
        
    }
    
    private func setEditableMode(mode: Bool) {
        titleTextField.isUserInteractionEnabled = mode
        datePicker.isUserInteractionEnabled = mode
        descriptionTextView.isUserInteractionEnabled = mode
    }
    
    private func setUpSelectedTask() {
        guard let indexPathRow = indexPathRow,
              let taskListVM = taskListVM else { return }
        switch status {
        case .todo:
            let task = taskListVM.todoTasks[indexPathRow]
            configureTask(task: task)
        case .doing:
            let task = taskListVM.doingTasks[indexPathRow]
            configureTask(task: task)
        case .done:
            let task = taskListVM.doneTasks[indexPathRow]
            configureTask(task: task)
        default:
            break
        }
    }
    
    private func configureTask(task: Task) {
        titleTextField.text = task.title
        datePicker.date = task.date ?? Date()
        descriptionTextView.text = task.description
    }
    
    func setUpTaskListVM(_ taskListVM: TaskListViewModel) {
        self.taskListVM = taskListVM
    }
    
    func setUpDelegateInfo(info: DelegateInfo) {
        indexPathRow = info.indexPathRow
        status = info.status
    }
}
