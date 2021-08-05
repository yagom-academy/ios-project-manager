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
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var alertNavigationBar: UINavigationBar!
    
    weak var taskDelegate: TaskDelegate?
    var selectTask: Task?
    let cancelBarButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancelButton))
    let editBarButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(didTapEditButton))
    let doneBarButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDoneButton))
    var leftBarButton: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = doneBarButton
        alertNavigationBar.items = [navigationItem]
        
        self.view.layer.cornerRadius = 16
        self.view.layer.borderWidth = 2
        self.view.layer.borderColor = UIColor.white.cgColor
        
        self.alertNavigationBar.topItem?.title = "TODO"
        
        setSelectTask()
        setBorderStyle()
        taskTextView.delegate = self
        taskTextField.addTarget(self, action: #selector(changedTextField), for: .editingChanged)
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
    
    private func setBorderStyle() {
        taskTextView.clipsToBounds = false
        taskTextView.layer.shadowOpacity = 0.4
        taskTextView.layer.shadowOffset = CGSize(width: 3, height: 3)
        taskTextField.clipsToBounds = false
        taskTextField.layer.shadowOpacity = 0.4
        taskTextField.layer.shadowOffset = CGSize(width: 3, height: 3)
    }
    
    @objc func didTapCancelButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @objc func didTapEditButton(_ sender: Any) {
        taskTextField.isEnabled = true
        taskTextView.isEditable = true
        datePicker.isEnabled = true
    }
    
    @objc func didTapDoneButton(_ sender: Any) {
        guard let title = taskTextField.text else { return }
        
        if alertNavigationBar.items?[0] == cancelBarButton && title.isEmpty == false {
            taskDelegate?.addTask(self, task: Task(id: nil,
                                              title: title,
                                              content: taskTextView.text,
                                              deadLineDate: datePicker.date,
                                              category: .todo))
        } else if alertNavigationBar.items?[0] == editBarButton {
            guard let selectTitle = taskTextField.text,
                  let selectBody = taskTextView.text,
                  let selectTask = selectTask
            else {
                self.dismiss(animated: true)
                return
            }
            
            taskDelegate?.patchTask(self, task: Task(id: nil,
                                                     title: selectTitle,
                                                     content: selectBody,
                                                     deadLineDate: datePicker.date,
                                                     category: selectTask.category))
        }
        
        self.dismiss(animated: true)
    }
    
    @objc func changedTextField(_ sender: Any?) {
        
    }
    
    @IBAction func changedDatePicker(_ sender: UIDatePicker) {
        
    }
}

extension TaskAlertViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        
    }
}
