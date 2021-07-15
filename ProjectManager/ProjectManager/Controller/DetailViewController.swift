//
//  DetailViewController.swift
//  ProjectManager
//
//  Created by Seungjin Baek on 2021/07/15.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var taskTitle: UITextField!
    @IBOutlet weak var taskDeadline: UIDatePicker!
    @IBOutlet weak var taskContent: UITextView!
    
    
    
    @IBAction func didTapDone(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func didTapCancel(_ sender: UIBarButtonItem) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func presentCurrentData(of tasks: [Task], at index: Int) {
        let task = tasks[index]
        self.taskTitle.text = task.title
        self.taskDeadline.date = task.deadlineDate
        self.taskContent.text = task.content
    } // IB 아울렛으로 변수를 가져오는게 비동기라 nil이 발생 -> 해결방법 검색
    
    func setHeaderTitle(with title: String) {
        self.navigationItem.title = title
    }
    
}
