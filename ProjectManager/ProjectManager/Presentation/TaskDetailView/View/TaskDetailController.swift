import UIKit

class TaskDetailController: UIViewController {
    private var taskListViewModel: TaskListViewModelProtocol?
    private var taskDetailViewModel: TaskDetailViewModelProtocol?
    weak var flowCoordinator: FlowCoordinator?
    
    private var taskManagerAction: TaskManagerAction!
    private var taskToEdit: Task?
    
    @IBOutlet private weak var titleLabel: UITextField!
    @IBOutlet private weak var datePicker: UIDatePicker!
    @IBOutlet private weak var bodyTextView: UITextView!
    
    convenience init?(coder: NSCoder, taskListViewModel: TaskListViewModelProtocol, taskDetailViewModel: TaskDetailViewModelProtocol?, taskManagerAction: TaskManagerAction, taskToEdit: Task?) {
        self.init(coder: coder)
        self.taskListViewModel = taskListViewModel
        self.taskDetailViewModel = taskDetailViewModel
        self.taskManagerAction = taskManagerAction
        self.taskToEdit = taskToEdit
    }
    
    override func viewDidLoad() {
        applyTaskToEditIfExists()
        setupNavigationBar()
    }
    
    private func applyTaskToEditIfExists() {
        guard taskManagerAction == .edit, let taskToEdit = taskToEdit else { return }
        
        titleLabel.text = taskToEdit.title
        datePicker.date = taskToEdit.dueDate
        bodyTextView.text = taskToEdit.body
    }
    
    private func setupNavigationBar() {
        title = taskToEdit?.processStatus.description ?? ProcessStatus.todo.description
        
        setupLeftBarButton()
        setupRightBarButton()
    }
    
    private func setupLeftBarButton() {
        guard let leftBarCancelButton = taskDetailViewModel?.leftBarButton(of: taskManagerAction) else {
            return
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: leftBarCancelButton,
                                                           target: self,
                                                           action: #selector(touchUpLeftBarCancelButton))
    }
    
    @objc private func touchUpLeftBarCancelButton() {
        switch taskManagerAction {
        case .add:
            dismiss(animated: true, completion: nil)
        case .edit:
            dismiss(animated: true, completion: nil)
        case .none:
            print(TaskManagerError.invalidTaskManagerAction)
        }
    }
    
    private func setupRightBarButton() {
        guard let rightBarButton = taskDetailViewModel?.rightBarButton(of: taskManagerAction) else {
            return
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: rightBarButton,
                                                           target: self,
                                                           action: #selector(touchUpRightBarButton))
    }
    
    @objc private func touchUpRightBarButton() {
        let newTask = createTaskWithUserInput()
        
        switch taskManagerAction {
        case .add:
            taskListViewModel?.create(task: newTask)
            dismiss(animated: true, completion: nil)
        case .edit:
            taskListViewModel?.edit(task: taskToEdit!, newTitle: newTask.title, newBody: newTask.body, newDueDate: newTask.dueDate)
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
