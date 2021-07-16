//
//  AddTaskViewController.swift
//  ProjectManager
//
//  Created by Seungjin Baek on 2021/07/13.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    var delegate: ModalDelegate?

    @IBOutlet weak var todoTaskTitle: UITextField!
    @IBOutlet weak var todoTaskDeadlineDate: UIDatePicker!
    @IBOutlet weak var todoTaskContent: UITextView!
    
    @IBAction func didTapDone(_ sender: UIBarButtonItem) {
        delegate?.addToDoList(task: creatToDoTask())
        guard let presentingViewController = self.presentingViewController as? TableViewReloadable else { return }
        presentingViewController.reloadToDoTableView()
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapCancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
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
    
    private func creatToDoTask() -> Task {
        let task = Task(id: "", title: todoTaskTitle.text ?? "", content: todoTaskContent.text ?? "", deadlineDate: todoTaskDeadlineDate.date, classification: "todo")
        return task
    }
}
