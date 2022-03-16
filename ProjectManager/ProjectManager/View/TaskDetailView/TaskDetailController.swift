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
    }
    
    override func viewDidLoad() {
        applyTaskToEditIfExists()
        setupLeftBarButton()
    }
    
    func applyTaskToEditIfExists() {
        guard taskManagerAction == .edit, let taskToEdit = taskToEdit else { return }
        
        title = taskToEdit.processStatus.description
        titleLabel.text = taskToEdit.title
        datePicker.date = taskToEdit.dueDate
        bodyTextView.text = taskToEdit.body
    }
    
    func setupLeftBarButton() {
        let leftBarButton = taskManagerAction.leftBarButton
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: leftBarButton,
                                                           target: self,
                                                           action: #selector(touchUpLeftBarButton))
    }
    
    @objc func touchUpLeftBarButton() {
        switch taskManagerAction {
        case .add: // cancle
            dismiss(animated: true, completion: nil)
        case .edit: // edit
            let newTask = createTaskWithUserInput()
            taskListViewModel?.edit(task: taskToEdit!, newTitle: newTask.title, newBody: newTask.body, newDueDate: newTask.dueDate)
            dismiss(animated: true, completion: nil)
        case .none:
            print(TaskManagerError.invalidTaskManagerAction)
        }
    }
    
    @IBAction private func touchUpDoneButton(_ sender: UIBarButtonItem) {
        let newTask = createTaskWithUserInput()
        
        switch taskManagerAction {
        case .add: // add
            taskListViewModel?.create(task: newTask)
            dismiss(animated: true, completion: nil)
        case .edit: // cancel
            dismiss(animated: true, completion: nil)
        case .none:
            print(TaskManagerError.invalidTaskManagerAction)
        }
    }
    
    private func createTaskWithUserInput() -> Task {
        let inputTitle = titleLabel.text ?? ""
        let inputDate = datePicker.date
        let inputBody = bodyTextView.text ?? ""
        
        return Task(title: inputTitle, body: inputBody, dueDate: inputDate)
    }
}
