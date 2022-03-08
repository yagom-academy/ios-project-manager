import UIKit

final class TaskListViewController: UIViewController {
    private let taskListViewModel = TaskListViewModel()
    
    @IBOutlet weak var todoTableView: UITableView!
    @IBOutlet weak var doingTableView: UITableView!
    @IBOutlet weak var doneTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableViews()
        setupBindings()
    }
    
    func setupTableViews() {
//        taskListViewModel.delegate = self  // binding으로 대체
        
        todoTableView.dataSource = self  // 이 이후에 numberOfRowsInSection 메서드가 호출됨
        let nib1 = UINib(nibName: "TaskTableViewCell", bundle: nil)
        todoTableView.register(nib1, forCellReuseIdentifier: "TaskTableViewCell")
        
        doingTableView.dataSource = self
        let nib2 = UINib(nibName: "TaskTableViewCell", bundle: nil)
        doingTableView.register(nib2, forCellReuseIdentifier: "TaskTableViewCell")

        doneTableView.dataSource = self
        let nib3 = UINib(nibName: "TaskTableViewCell", bundle: nil)
        doneTableView.register(nib3, forCellReuseIdentifier: "TaskTableViewCell")
    }
    
    func setupBindings() {
        taskListViewModel.todoTasksObservable.bind { [weak self] task in
            print("test: todoTasksObservable 변경으로 인해 listener(value)를 실행")
//            todoTitle.text = task.count
            self?.todoTableView.reloadData()
        }
        
        taskListViewModel.doingTasksObservable.bind { [weak self] todoTask in
            print("test: doingTasksObservable 변경으로 인해 listener(value)를 실행")
            self?.doingTableView.reloadData()
        }
        
        taskListViewModel.doneTasksObservable.bind { [weak self] todoTask in
            print("test: doneTasksObservable 변경으로 인해 listener(value)를 실행")
            self?.doneTableView.reloadData()
        }
    }
    
    
}

// MARK: - IBAction
extension TaskListViewController {
    @IBAction func touchUpAddButton(_ sender: UIBarButtonItem) {
        let newTask = Task(title: "새로운 작업", body: "작업 내용을 입력해주세요.", dueDate: Date())
        taskListViewModel.create(task: newTask, of: .todo)
//        todoTableView.reloadData() // Observable 덕분에 todoTasksObservable 값이 변경되면 자동으로 reloadData가 호출됨
    }
}

// MARK: - TableView DataSource
extension TaskListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case todoTableView:
            return taskListViewModel.numberOfRowsInSection(forTableOf: .todo)
        case doingTableView:
            return taskListViewModel.numberOfRowsInSection(forTableOf: .doing)
        case doneTableView:
            return taskListViewModel.numberOfRowsInSection(forTableOf: .done)
        default:
            print(TableViewError.invalidTableView.description)
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: TaskTableViewCell.self, for: indexPath)
        
        switch tableView {
        case todoTableView:
            cell.applyDate(with: taskListViewModel.todoTasksObservable.value[indexPath.row])
        case doingTableView:
            cell.applyDate(with: taskListViewModel.doingTasksObservable.value[indexPath.row])
        case doneTableView:
            cell.applyDate(with: taskListViewModel.doneTasksObservable.value[indexPath.row])
        default:
            print(TableViewError.invalidTableView.description)
            cell.applyDate(with: taskListViewModel.todoTasksObservable.value[indexPath.row])
        }
        
        return cell
    }
}

// MARK: - TableView Delegate
//extension TaskListViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        switch tableView {
//        case todoTableView:
////            cell.applyDate(with: taskListViewModel.todoTasks[indexPath.row])
//        case doingTableView:
////            cell.applyDate(with: taskListViewModel.doingTasks[indexPath.row])
//        case doneTableView:
////            cell.applyDate(with: taskListViewModel.doneTasks[indexPath.row])
//        default:
//            print(TableViewError.invalidTableView.description)
//        }
//    }
//}

// MARK: - TableView Header
extension TaskListViewController {
    // TODO: Custom HeaderView 추가
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch tableView {
        case todoTableView:
            return taskListViewModel.titleForHeaderInSection(forTableOf: .todo)
        case doingTableView:
            return taskListViewModel.titleForHeaderInSection(forTableOf: .doing)
        case doneTableView:
            return taskListViewModel.titleForHeaderInSection(forTableOf: .done)
        default:
            print(TableViewError.invalidTableView.description)
            return ""
        }
    }
}
