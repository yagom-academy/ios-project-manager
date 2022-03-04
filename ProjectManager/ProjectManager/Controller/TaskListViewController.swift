import UIKit

class TaskListViewController: UIViewController {
    var todoTasks: [Task] = []
    var doingTasks: [Task] = []
    var doneTasks: [Task] = []
    
    @IBOutlet weak var todoTableView: UITableView!
    @IBOutlet weak var doingTableView: UITableView!
    @IBOutlet weak var doneTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        todoTasks.append(newTask)
        todoTableView.reloadData()
        
        doingTasks.append(newTask)
        doingTableView.reloadData()
        
        doneTasks.append(newTask)
        doneTableView.reloadData()
    }
}

extension TaskListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as? TaskTableViewCell else {
            return UITableViewCell()
        }
        
        cell.applyDate(with: todoTasks[indexPath.row])
        
        return cell
    }
}

