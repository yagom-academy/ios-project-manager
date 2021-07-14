//
//  AddTaskViewController.swift
//  ProjectManager
//
//  Created by Seungjin Baek on 2021/07/13.
//

import UIKit

class AddTaskViewController: UIViewController {

    @IBOutlet weak var todoTaskTitle: UITextField!
    @IBOutlet weak var todoTaskDeadlineDate: UIDatePicker!
    @IBOutlet weak var todoTaskContent: UITextView!
    
    @IBAction func didTapDone(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func didTapCancel(_ sender: UIBarButtonItem) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addShadowEffect()
    }
    
    private func addShadowEffect() {
        todoTaskTitle.layer.shadowColor = UIColor.black.cgColor
        todoTaskTitle.layer.shadowOpacity = 0.5
        todoTaskTitle.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        todoTaskTitle.layer.shadowRadius = 5
        
        todoTaskContent.layer.shadowPath = UIBezierPath(rect: todoTaskContent.bounds).cgPath
        todoTaskContent.layer.borderWidth = 1
    }
}
