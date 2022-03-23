import UIKit
import RxSwift
import RxCocoa

private enum Design {
    static let swipeDeleteTitle = "Delete"
    static let swipeDeleteImageName = "xmark.bin.fill"
}

final class TaskListViewController: UIViewController {
    // MARK: - Properties
    private var taskListViewModel: TaskListViewModelProtocol!
    private var disposeBag = DisposeBag()
    
    private var todoTaskHeaderView: TaskTableHeaderView!
    private var doingTaskHeaderView: TaskTableHeaderView!
    private var doneTaskHeaderView: TaskTableHeaderView!
    
    @IBOutlet private weak var todoTableView: TaskTableView!
    @IBOutlet private weak var doingTableView: TaskTableView!
    @IBOutlet private weak var doneTableView: TaskTableView!
    
    // MARK: - Initializers
    convenience init?(coder: NSCoder, taskListViewModel: TaskListViewModelProtocol) {
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
        todoTaskHeaderView = TaskTableHeaderView(reuseIdentifier: TaskTableHeaderView.reuseIdentifier,
                                                 processStatus: .todo)
        doingTaskHeaderView = TaskTableHeaderView(reuseIdentifier: TaskTableHeaderView.reuseIdentifier,
                                                  processStatus: .doing)
        doneTaskHeaderView = TaskTableHeaderView(reuseIdentifier: TaskTableHeaderView.reuseIdentifier,
                                                 processStatus: .done)

        todoTableView.tableHeaderView = todoTaskHeaderView
        doingTableView.tableHeaderView = doingTaskHeaderView
        doneTableView.tableHeaderView = doneTaskHeaderView
    }
    
    private func setupBindings() {
        setupTableViewsBinding()
        setupHeaderViewsBinding()
    }
    
    private func setupTableViewsBinding() {
        taskListViewModel.todoTasks
            .asDriver(onErrorJustReturn: [])
            .drive(todoTableView.rx.items(cellIdentifier: TaskTableViewCell.reuseIdentifier,
                                          cellType: TaskTableViewCell.self)) { [weak self] _, task, cell in
                cell.update(with: task, viewModel: self!.taskListViewModel)
             }
             .disposed(by: disposeBag)
        
        taskListViewModel.doingTasks
            .asDriver(onErrorJustReturn: [])
            .drive(doingTableView.rx.items(cellIdentifier: TaskTableViewCell.reuseIdentifier,
                                           cellType: TaskTableViewCell.self)) { [weak self] _, task, cell in
                cell.update(with: task, viewModel: self!.taskListViewModel)
             }
             .disposed(by: disposeBag)

        taskListViewModel.doneTasks
            .asDriver(onErrorJustReturn: [])
            .drive(doneTableView.rx.items(cellIdentifier: TaskTableViewCell.reuseIdentifier,
                                          cellType: TaskTableViewCell.self)) { [weak self] _, task, cell in
                cell.update(with: task, viewModel: self!.taskListViewModel)
             }
             .disposed(by: disposeBag)
    }
    
    private func setupHeaderViewsBinding() {
        taskListViewModel.todoTasksCount
            .map { "\($0)" }
            .asDriver(onErrorJustReturn: "")
            .drive(todoTaskHeaderView.taskCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        taskListViewModel.doingTasksCount
            .map { "\($0)" }
            .asDriver(onErrorJustReturn: "")
            .drive(doingTaskHeaderView.taskCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        taskListViewModel.doneTasksCount
            .map { "\($0)" }
            .asDriver(onErrorJustReturn: "")
            .drive(doneTaskHeaderView.taskCountLabel.rx.text)
            .disposed(by: disposeBag)
    }
}

// MARK: - IBAction
extension TaskListViewController {
    @IBAction private func touchUpAddButton(_ sender: UIBarButtonItem) {
        taskListViewModel.didTouchUpAddButton()
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

        taskListViewModel.didSelectTask(at: indexPath.row, inTableViewOf: selectedProcessStatus)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let tableView = tableView as? TaskTableView,
              let selectedProcessStatus = tableView.processStatus else {
                  print(TableViewError.invalidTableView.description)
                  return UISwipeActionsConfiguration()
              }
        
        let deleteAction = createSwipeDeleteAction(for: indexPath.row, ofProcessStatus: selectedProcessStatus)
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        
        return configuration
    }
    
    func createSwipeDeleteAction(for taskAtRow: Int, ofProcessStatus: ProcessStatus) -> UIContextualAction {
        let deleteAction = UIContextualAction(style: .destructive, title: Design.swipeDeleteTitle) { [weak self] _, _, handler in
            self?.taskListViewModel.didSwipeDeleteAction(for: taskAtRow, inTableViewOf: ofProcessStatus)
            handler(true)
        }
        deleteAction.image = UIImage(systemName: Design.swipeDeleteImageName)
        
        return deleteAction
    }
}
