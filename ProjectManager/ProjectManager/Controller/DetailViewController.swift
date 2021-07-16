//
//  DetailViewController.swift
//  ProjectManager
//
//  Created by Seungjin Baek on 2021/07/15.
//

import UIKit

class DetailViewController: UIViewController {
    
    var delegate: ModalDelegate?
    var selectedIndexPath: IndexPath?
    var currentTableView: UITableView!
    
    weak var toDoTableView: UITableView!
    weak var doingTableView: UITableView!
    weak var doneTableView: UITableView!
    
    @IBOutlet weak var taskTitle: UITextField!
    @IBOutlet weak var taskDeadline: UIDatePicker!
    @IBOutlet weak var taskContent: UITextView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBAction func didTapDone(_ sender: UIBarButtonItem) {
        guard let presentingViewController = self.presentingViewController as? TableViewReloadable else { return }
        
        self.presentingViewController?.dismiss(animated: true) {
            presentingViewController.reloadToDoTableView()
            presentingViewController.reloadDoingTableView()
            presentingViewController.reloadDoneTableView()
        }
        editContents(of: currentTableView)
        
    }
    
    @IBAction func didTapEdit(_ sender: UIBarButtonItem) {
        taskTitle.isUserInteractionEnabled = true
        taskDeadline.isUserInteractionEnabled = true
        taskContent.isUserInteractionEnabled = true
        taskTitle.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskTitle.isUserInteractionEnabled = false
        taskDeadline.isUserInteractionEnabled = false
        taskContent.isUserInteractionEnabled = false
    }
    
    func presentCurrentData(of tasks: [Task], at index: Int) {
        let task = tasks[index]
        self.taskTitle.text = task.title
        self.taskDeadline.date = task.deadlineDate
        self.taskContent.text = task.content
    } // IB 아울렛으로 변수를 가져오는게 비동기라 nil이 발생 -> 해결방법 검색
    
    func setHeaderTitle(with title: String) {
        self.navigationBar.topItem?.title = title
    }
    
    private func creatToDoTask() -> Task {
        let task = Task(id: "", title: taskTitle.text ?? "", content: taskContent.text ?? "", deadlineDate: taskDeadline.date, classification: "todo")
        return task
    }

    func editContents(of tableView: UITableView) {
        guard let viewController = self.presentingViewController as? ViewController,
              let datasource = viewController.datasource,
              let selectedIndexPath = selectedIndexPath else { return }
        let taskList: [Task]
        switch tableView {
        case toDoTableView:
            taskList = datasource.fetchToDoList()
        case doingTableView:
            taskList = datasource.fetchDoingList()
        case doneTableView:
            taskList = datasource.fetchDoneList()
        default:
            taskList = []
        }
        
        datasource.modifyList(target: taskList ,title: taskTitle.text ?? "", deadlineDate: taskDeadline.date, content: taskContent.text ?? "", index: selectedIndexPath.row)
    }
    
    
    
    
}
