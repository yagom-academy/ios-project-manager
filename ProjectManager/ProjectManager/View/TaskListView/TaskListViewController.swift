import UIKit

final class TaskListViewController: UIViewController {
    // MARK: - Properties
    private var taskListViewModel: TaskListViewModelProtocol!
    private lazy var tableViews = [todoTableView, doingTableView, doneTableView]
    
    @IBOutlet private weak var todoTableView: TaskTableView!
    @IBOutlet private weak var doingTableView: TaskTableView!
    @IBOutlet private weak var doneTableView: TaskTableView!
    
    // MARK: - Initializers
    convenience init?(coder: NSCoder, taskListViewModel: TaskListViewModelProtocol = TaskListViewModel()) {
        self.init(coder: coder)
        self.taskListViewModel = taskListViewModel
    }

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableViews()
        setupBindings()
    }
        
    private func setupTableViews() {
        todoTableView.processStatus = .todo
        doingTableView.processStatus = .doing
        doneTableView.processStatus = .done
        
        tableViews.forEach { tableView in
            tableView?.dataSource = self
            tableView?.delegate = self
            let nib = UINib(nibName: TaskTableViewCell.reuseIdentifier, bundle: nil)
            todoTableView.register(nib, forCellReuseIdentifier: TaskTableViewCell.reuseIdentifier)
        }
    }
    
    private func setupBindings() {
        taskListViewModel.todoTasksObservable?.bind { [weak self] task in
            self?.todoTableView.reloadData()
        }
        taskListViewModel.doingTasksObservable?.bind { [weak self] task in
            self?.doingTableView.reloadData()
        }
        taskListViewModel.doneTasksObservable?.bind { [weak self] task in
            self?.doneTableView.reloadData()
        }
    }
}

// MARK: - IBAction
extension TaskListViewController {
    @IBAction private func touchUpAddButton(_ sender: UIBarButtonItem) {
        let taskDetailController = ViewControllerFactory.createViewController(of: .taskDetail(viewModel: self.taskListViewModel))
        taskDetailController.modalPresentationStyle = .popover
        
        self.present(UINavigationController(rootViewController: taskDetailController), animated: true)
    }
}

// MARK: - TableView DataSource
extension TaskListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let tableView = tableView as? TaskTableView else {
            print(TableViewError.invalidTableView)
            return 0
        }
        
        return taskListViewModel.numberOfRowsInSection(for: tableView)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: TaskTableViewCell.self, for: indexPath)
        
        switch tableView {
        case todoTableView:
            cell.applyDate(with: taskListViewModel.todoTasksObservable?.value[indexPath.row])
        case doingTableView:
            cell.applyDate(with: taskListViewModel.doingTasksObservable?.value[indexPath.row])
        case doneTableView:
            cell.applyDate(with: taskListViewModel.doneTasksObservable?.value[indexPath.row])
        default:
            print(TableViewError.invalidTableView.description)
        }
        
        return cell
    }
}

// MARK: - TableView Delegate
extension TaskListViewController: UITableViewDelegate {
    // TODO: Cell을 탭하면 Popover 표시
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        switch tableView {
//        case todoTableView:
//        case doingTableView:
//        case doneTableView:
//        default:
//            print(TableViewError.invalidTableView.description)
//        }
//    }
}

// MARK: - TableView Header
extension TaskListViewController {
    // TODO: Custom HeaderView 추가
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let tableView = tableView as? TaskTableView else {
            print(TableViewError.invalidTableView)
            return ""
        }
        
        return taskListViewModel.titleForHeaderInSection(for: tableView)
    }
}
