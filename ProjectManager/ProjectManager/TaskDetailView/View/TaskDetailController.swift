import UIKit

class TaskDetailController: UIViewController {
    let taskListViewModel = TaskListViewModel()
    
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var bodyTextView: UITextView!
    
    func createTask() -> Task {
        let inputTitle = titleLabel.text ?? ""
        let inputDate = datePicker.date
        let inputBody = bodyTextView.text ?? ""
        
        return Task(title: inputTitle, body: inputBody, dueDate: inputDate)
    }
    
    @IBAction func touchUpCancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchUpDoneButton(_ sender: UIBarButtonItem) {
        let newTask = createTask()
        taskListViewModel.create(task: newTask, of: .todo) // Bug: 1) 사용자가 입력한 Task가 todoTable에 추가되지 않음, 2) todoTasksObservable의 value 배열이 덮어쓰기됨
    }
}

