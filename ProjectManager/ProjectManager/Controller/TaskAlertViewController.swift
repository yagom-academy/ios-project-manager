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
    
    var selectTitle: String?
    var selectBody: String?
    var selectDeadLine: Date?
    var selectTask: Task?
    
    var leftBarButtonName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.layer.cornerRadius = 16
        self.view.layer.borderWidth = 2
        self.view.layer.borderColor = UIColor.white.cgColor
        
        self.leftBarButton.title = leftBarButtonName
        
        taskTextView.delegate = self
        taskTextField.addTarget(self, action: #selector(changedTextField), for: .editingChanged)
        
        setSelectTask()
    }
    
    private func setSelectTask() {
        guard let selectTask = selectTask else { return }
        
        taskTextField.text = selectTask.title
        taskTextView.text = selectTask.content
        datePicker.date = selectTask.deadLineDate
        self.alertNavigationBar.topItem?.title = selectTask.category.rawValue.uppercased()
    }
    
    @objc func changedTextField() {
        selectTitle = taskTextField.text
    }
    
    @IBAction func getDeadLine(_ sender: UIDatePicker) {
        selectDeadLine = sender.date
    }
    
    @IBAction func finishEditTask(_ sender: Any) {
        if let title = taskTextField.text,
           title.isEmpty == false {
            taskDelegate?.sendTask(self, task: Task(id: nil,
                                              title: title,
                                              content: taskTextView.text,
                                              deadLineDate: datePicker.date,
                                              category: .todo))
        }
        self.dismiss(animated: true)
    }
    
    @IBAction func didTapLeftBarButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension TaskAlertViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        selectBody = self.taskTextView.text
    }
}
