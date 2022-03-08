import UIKit

class TaskDetailController: UIViewController {
    private var taskListViewModel: TaskListViewModelProtocol?
    
    @IBOutlet private weak var titleLabel: UITextField!
    @IBOutlet private weak var datePicker: UIDatePicker!
    @IBOutlet private weak var bodyTextView: UITextView!
    
    convenience init?(coder: NSCoder, taskListViewModel: TaskListViewModelProtocol) {
        self.init(coder: coder)
        self.taskListViewModel = taskListViewModel
    }
    
    @IBAction private func touchUpCancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func touchUpDoneButton(_ sender: UIBarButtonItem) {
        let newTask = createTask()
        taskListViewModel?.create(task: newTask)
        dismiss(animated: true, completion: nil)
    }
    
    private func createTask() -> Task {
        let inputTitle = titleLabel.text ?? ""
        let inputDate = datePicker.date
        let inputBody = bodyTextView.text ?? ""
        
        return Task(title: inputTitle, body: inputBody, dueDate: inputDate)
    }
}
