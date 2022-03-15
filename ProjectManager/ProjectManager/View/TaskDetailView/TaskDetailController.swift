import UIKit

class TaskDetailController: UIViewController {
    private var taskListViewModel: TaskListViewModelProtocol?
    var taskManagerAction: TaskManagerAction!
    var taskToEdit: Task?
    
    @IBOutlet private weak var titleLabel: UITextField!
    @IBOutlet private weak var datePicker: UIDatePicker!
    @IBOutlet private weak var bodyTextView: UITextView!
    
    convenience init?(coder: NSCoder, taskListViewModel: TaskListViewModelProtocol, taskManagerAction: TaskManagerAction, taskToEdit: Task?) {
        self.init(coder: coder)
        self.taskListViewModel = taskListViewModel
        self.taskManagerAction = taskManagerAction
        self.taskToEdit = taskToEdit
        
        setupLeftBarButton()
    }
    
    func setupLeftBarButton() {
        let leftBarButton = taskManagerAction.leftBarButton
        self.navigationController?.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: leftBarButton, target: self, action: #selector(touchUpLeftBarButton))
    }
    
    @objc func touchUpLeftBarButton() {
        switch taskManagerAction {
        case .add: // cancle
            dismiss(animated: true, completion: nil)
        case .edit: // edit
            let newTask = createTask()
            taskListViewModel?.update(task: taskToEdit!, to: newTask)
            dismiss(animated: true, completion: nil)
        case .none:
            print(TaskManagerError.invalidTaskManagerAction)
        }
    }
    
    func setupRightBarButton() {
        
    }
    
    @objc func touchUpRightBarButton() {
        
    }
    
    // dynamic하게 변하는거라 못쓰나보다
//    @IBAction private func touchUpCancelButton(_ sender: UIBarButtonItem) {
//        dismiss(animated: true, completion: nil)
//    }
    
    @IBAction private func touchUpDoneButton(_ sender: UIBarButtonItem) {
        let newTask = createTask()
        
        switch taskManagerAction {
        case .add: // 완료 -> 추가
            taskListViewModel?.create(task: newTask)
            dismiss(animated: true, completion: nil)
        case .edit: // 완료 -> 취소? 수정?
            taskListViewModel?.update(task: taskToEdit!, to: newTask)
            dismiss(animated: true, completion: nil)
        case .none:
            print(TaskManagerError.invalidTaskManagerAction)
        }
    }
    
    private func createTask() -> Task {
        let inputTitle = titleLabel.text ?? ""
        let inputDate = datePicker.date
        let inputBody = bodyTextView.text ?? ""
        
        return Task(title: inputTitle, body: inputBody, dueDate: inputDate)
    }
}
