import UIKit
import RxSwift
import RxCocoa

final class TaskListViewController: UIViewController {
    // MARK: - Properties
    private var taskListViewModel: TaskListViewModelProtocol!
    private var disposeBag = DisposeBag()
    
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
        setupHeaderViews()
        setupBindings()
    }
        
    private func setupTableViews() {
        todoTableView.setup(processStatus: .todo)
        doingTableView.setup(processStatus: .doing)
        doneTableView.setup(processStatus: .done)
    }
    
    private func setupHeaderViews() {
        let todoTaskHeaderView = TaskTableHeaderView(reuseIdentifier: TaskTableHeaderView.reuseIdentifier,
                                                     taskCount: taskListViewModel.todoTasksCount, // 기존 ViewModel의 일부 데이터를 생성자 주입으로 전달
                                                     processStatus: .todo)
        let doingTaskHeaderView = TaskTableHeaderView(reuseIdentifier: TaskTableHeaderView.reuseIdentifier,
                                                      taskCount: taskListViewModel.doingTasksCount,
                                                      processStatus: .doing)
        let doneTaskHeaderView = TaskTableHeaderView(reuseIdentifier: TaskTableHeaderView.reuseIdentifier,
                                                     taskCount: taskListViewModel.doneTasksCount,
                                                     processStatus: .done)

        todoTableView.tableHeaderView = todoTaskHeaderView
        doingTableView.tableHeaderView = doingTaskHeaderView
        doneTableView.tableHeaderView = doneTaskHeaderView
    }
    
    private func setupBindings() {
        setupTableViewsBinding()
    }
    
    private func setupTableViewsBinding() {
        taskListViewModel.todoTasks
            .asDriver(onErrorJustReturn: [])
            .drive(todoTableView.rx.items(cellIdentifier: TaskTableViewCell.reuseIdentifier,
                                          cellType: TaskTableViewCell.self)) { [weak self] _, task, cell in
                cell.setup(with: task, popoverPresenterDelegate: self!, viewModel: self!.taskListViewModel)
             }
             .disposed(by: disposeBag)
        
        taskListViewModel.doingTasks
            .asDriver(onErrorJustReturn: [])
            .drive(doingTableView.rx.items(cellIdentifier: TaskTableViewCell.reuseIdentifier,
                                           cellType: TaskTableViewCell.self)) { [weak self] _, task, cell in
                cell.setup(with: task, popoverPresenterDelegate: self!, viewModel: self!.taskListViewModel)
             }
             .disposed(by: disposeBag)

        taskListViewModel.doneTasks
            .asDriver(onErrorJustReturn: [])
            .drive(doneTableView.rx.items(cellIdentifier: TaskTableViewCell.reuseIdentifier,
                                          cellType: TaskTableViewCell.self)) { [weak self] _, task, cell in
                cell.setup(with: task, popoverPresenterDelegate: self!, viewModel: self!.taskListViewModel)
             }
             .disposed(by: disposeBag)
    }
}

// MARK: - IBAction
extension TaskListViewController {
    @IBAction private func touchUpAddButton(_ sender: UIBarButtonItem) {
        let taskDetailController = ViewControllerFactory.createViewController(of: .newTaskDetail(viewModel: self.taskListViewModel))
        taskDetailController.modalPresentationStyle = .popover
        self.present(UINavigationController(rootViewController: taskDetailController), animated: true)
    }
}

// MARK: - TableView Delegate
extension TaskListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let tableView = tableView as? TaskTableView,
              let selectedProcessStatus = tableView.processStatus else {
                  print(TableViewError.invalidTableView.description)
                  return
              }

        let taskDetailController = taskListViewModel.didSelectRow(at: indexPath.row, inTableViewOf: selectedProcessStatus)
        self.present(UINavigationController(rootViewController: taskDetailController), animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let tableView = tableView as? TaskTableView,
              let selectedProcessStatus = tableView.processStatus else {
                  print(TableViewError.invalidTableView.description)
                  return UISwipeActionsConfiguration()
              }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, handler in
            self?.taskListViewModel.didSwipeDeleteAction(at: indexPath.row, inTableViewOf: selectedProcessStatus)
            handler(true)  
        }
        deleteAction.image = UIImage(systemName: "xmark.bin.fill")
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        
        return configuration
    }
}

// MARK: - Popover
extension TaskListViewController: PopoverPresenterDelegate {
    func presentPopover(with alert: UIAlertController) {
        present(alert, animated: true)
    }
}
