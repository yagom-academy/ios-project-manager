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
    
    var tempTitle: String?
    var tempBody: String?
    var tempDeadLine: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.layer.cornerRadius = 16
        self.view.layer.borderWidth = 2
        self.view.layer.borderColor = UIColor.white.cgColor
        taskTextView.delegate = self
        taskTextField.addTarget(self, action: #selector(changedTextField), for: .editingChanged)
    }
    
    @objc func changedTextField() {
        tempTitle = taskTextField.text
    }
    
    @IBAction func getDeadLine(_ sender: UIDatePicker) {
        let datePicker = sender
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        tempDeadLine = formatter.string(from: datePicker.date)
    }
    
    @IBAction func finishEditTask(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}

extension TaskAlertViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        tempBody = self.taskTextView.text
    }
}
