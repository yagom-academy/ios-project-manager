import UIKit

// TaskListDataSource의 View를 그리는 delegate가 TaskListViewController이다.
class TaskListViewController: UIViewController, TaskListDataSourceDelegate {
    private let taskListDataSource = TaskListDataSource()
    
    @IBOutlet weak var todoTableView: UITableView!
    @IBOutlet weak var doingTableView: UITableView!
    @IBOutlet weak var doneTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskListDataSource.delegate = self // 이렇게 지정
        
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
        taskListDataSource.create(task: newTask)
        todoTableView.reloadData()
        
        taskListDataSource.create(task: newTask)
        doingTableView.reloadData()
        
        taskListDataSource.create(task: newTask)
        doneTableView.reloadData()
    }
}

extension TaskListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case todoTableView:
            return taskListDataSource.todoTasks.count ?? 0
        case doingTableView:
            return taskListDataSource.doingTasks.count ?? 0
        case doneTableView:
            return taskListDataSource.doneTasks.count ?? 0
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
            cell.applyDate(with: taskListDataSource.todoTasks[indexPath.row] )
        case doingTableView:
            cell.applyDate(with: taskListDataSource.todoTasks[indexPath.row] )
        case doneTableView:
            cell.applyDate(with: taskListDataSource.todoTasks[indexPath.row] )
        default:
            cell.applyDate(with: taskListDataSource.todoTasks[indexPath.row] )
        }
        
        cell.applyDate(with: taskListDataSource.todoTasks[indexPath.row] )
        
        return cell
    }
}

