//
//  TaskAlertViewController.swift
//  ProjectManager
//
//  Created by sookim on 2021/07/20.
//

import UIKit

class TaskAlertViewController: UIViewController {

    @IBOutlet weak var taskTextView: UITextView!
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var leftBarButton: UIBarButtonItem!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var alertNavigationBar: UINavigationBar!
    
    weak var taskDelegate: TaskDelegate?
    
    var selectTask: Task?
    
    var leftBarButtonName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.layer.cornerRadius = 16
        self.view.layer.borderWidth = 2
        self.view.layer.borderColor = UIColor.white.cgColor
        
        self.leftBarButton.title = leftBarButtonName
        
        setSelectTask()
    }
    
    private func setSelectTask() {
        guard let selectTask = selectTask else { return }
        
        taskTextField.text = selectTask.title
        taskTextView.text = selectTask.content
        datePicker.date = selectTask.deadLineDate
        self.alertNavigationBar.topItem?.title = selectTask.category.rawValue.uppercased()
        
        taskTextField.isEnabled = false
        taskTextView.isEditable = false
        datePicker.isEnabled = false
    }
    
    @IBAction func finishEditTask(_ sender: Any) {
        guard let title = taskTextField.text else { return }
           
        if title.isEmpty == false && self.leftBarButtonName == "Cancel" {
            taskDelegate?.sendTask(self, task: Task(id: nil,
                                              title: title,
                                              content: taskTextView.text,
                                              deadLineDate: datePicker.date,
                                              category: .todo))
        }
        else if self.leftBarButtonName == "Edit" {
            guard let selectTitle = taskTextField.text,
                  let selectBody = taskTextView.text,
                  let selectTask = selectTask
            else {
                self.dismiss(animated: true)
                return
            }
            
            taskDelegate?.patchTask(title: selectTitle,
                                    content: selectBody,
                                    deadLine: datePicker.date,
                                    category: selectTask.category
                                    )
        }
        
        self.dismiss(animated: true)
    }
    
    @IBAction func didTapLeftBarButton(_ sender: Any) {
        if self.leftBarButtonName == "Edit" {
            taskTextField.isEnabled = true
            taskTextView.isEditable = true
            datePicker.isEnabled = true
        }
        else {
            self.dismiss(animated: true)
        }
    }
}
