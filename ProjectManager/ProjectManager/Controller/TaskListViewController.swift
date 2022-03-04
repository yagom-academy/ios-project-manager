import UIKit

// TaskListDataSource의 View를 그리는 delegate가 TaskListViewController이다.
class TaskListViewController: UIViewController, TaskListViewProtocol {
    private let taskListViewModel = TaskListViewModel()
    
    @IBOutlet weak var todoTableView: UITableView!
    @IBOutlet weak var doingTableView: UITableView!
    @IBOutlet weak var doneTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskListViewModel.delegate = self // 이렇게 지정
        
        todoTableView.dataSource = self
        let nib1 = UINib(nibName: "TaskTableViewCell", bundle: nil)
        todoTableView.register(nib1, forCellReuseIdentifier: "TaskTableViewCell")
        
        doingTableView.dataSource = self
        let nib2 = UINib(nibName: "TaskTableViewCell", bundle: nil)
        doingTableView.register(nib2, forCellReuseIdentifier: "TaskTableViewCell")

        doneTableView.dataSource = self
        let nib3 = UINib(nibName: "TaskTableViewCell", bundle: nil)
        doneTableView.register(nib3, forCellReuseIdentifier: "TaskTableViewCell")
    }
    
    @IBAction func touchUpAddButton(_ sender: UIBarButtonItem) {
        let newTask = Task(title: "123", body: "123", dueDate: Date())
        taskListViewModel.create(task: newTask, of: .todo)
        todoTableView.reloadData()
        
        taskListViewModel.create(task: newTask, of: .doing)
        doingTableView.reloadData()
        
        taskListViewModel.create(task: newTask, of: .done)
        doneTableView.reloadData()
    }
}

extension TaskListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case todoTableView:
            return taskListViewModel.todoTasks.count
        case doingTableView:
            return taskListViewModel.doingTasks.count
        case doneTableView:
            return taskListViewModel.doneTasks.count 
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as? TaskTableViewCell else {
            return UITableViewCell()
        }
        
        switch tableView {
        case todoTableView:
            cell.applyDate(with: taskListViewModel.todoTasks[indexPath.row] )
        case doingTableView:
            cell.applyDate(with: taskListViewModel.doingTasks[indexPath.row] )
        case doneTableView:
            cell.applyDate(with: taskListViewModel.doneTasks[indexPath.row] )
        default:
            cell.applyDate(with: taskListViewModel.todoTasks[indexPath.row] )
        }
        
        return cell
    }
}

