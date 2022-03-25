import UIKit
import RxSwift
import RxCocoa

private enum Design {
    static let swipeDeleteTitle = "Delete"
    static let swipeDeleteImageName = "xmark.bin.fill"
}

final class TaskListViewController: UIViewController {
    // MARK: - Properties
    private var taskViewModel: TaskViewModelProtocol?
    private var taskListViewModel: TaskListViewModelProtocol?
    private var disposeBag = DisposeBag()
    
    private var todoTaskHeaderView: TaskTableHeaderView!
    private var doingTaskHeaderView: TaskTableHeaderView!
    private var doneTaskHeaderView: TaskTableHeaderView!
    
    @IBOutlet private weak var todoTableView: TaskTableView!
    @IBOutlet private weak var doingTableView: TaskTableView!
    @IBOutlet private weak var doneTableView: TaskTableView!
    
    // MARK: - Initializers
    convenience init?(coder: NSCoder, taskViewModel: TaskViewModelProtocol, taskListViewModel: TaskListViewModelProtocol) {
        self.init(coder: coder)
        self.taskViewModel = taskViewModel
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
        setupTableViewsCellBinding()
        setupTableViewsDidSelectCellBinding()
        setupTableViewsTrailingSwipeActionBinding()
        setupHeaderViewsBinding()
    }
    
    private func setupTableViewsCellBinding() {
        taskListViewModel?.todoTasks
            .asDriver(onErrorJustReturn: [])
            .drive(todoTableView.rx.items(cellIdentifier: TaskTableViewCell.reuseIdentifier,
                                          cellType: TaskTableViewCell.self)) { [weak self] _, task, cell in
                cell.update(with: task, taskViewModel: self?.taskViewModel, taskListViewModel: self?.taskListViewModel)
             }
             .disposed(by: disposeBag)
        
        taskListViewModel?.doingTasks
            .asDriver(onErrorJustReturn: [])
            .drive(doingTableView.rx.items(cellIdentifier: TaskTableViewCell.reuseIdentifier,
                                           cellType: TaskTableViewCell.self)) { [weak self] _, task, cell in
                cell.update(with: task, taskViewModel: self?.taskViewModel, taskListViewModel: self?.taskListViewModel)
             }
             .disposed(by: disposeBag)

        taskListViewModel?.doneTasks
            .asDriver(onErrorJustReturn: [])
            .drive(doneTableView.rx.items(cellIdentifier: TaskTableViewCell.reuseIdentifier,
                                          cellType: TaskTableViewCell.self)) { [weak self] _, task, cell in
                cell.update(with: task, taskViewModel: self?.taskViewModel, taskListViewModel: self?.taskListViewModel)
             }
             .disposed(by: disposeBag)
    }
    
    private func setupTableViewsDidSelectCellBinding() {
        todoTableView.rx.modelSelected(Task.self)
            .bind(onNext: { [weak self] in
                self?.taskListViewModel?.actions?.showTaskDetailToEditTask($0) })
            .disposed(by: disposeBag)
        
        doingTableView.rx.modelSelected(Task.self)
            .bind(onNext: { [weak self] in
                self?.taskListViewModel?.actions?.showTaskDetailToEditTask($0) })
            .disposed(by: disposeBag)
        
        doneTableView.rx.modelSelected(Task.self)
            .bind(onNext: { [weak self] in
                self?.taskListViewModel?.actions?.showTaskDetailToEditTask($0) })
            .disposed(by: disposeBag)
    }
     
    private func setupTableViewsTrailingSwipeActionBinding() {
        todoTableView.rx.modelDeleted(Task.self)
            .bind(onNext: { [weak self] in
                self?.taskListViewModel?.delete(task: $0) })
            .disposed(by: disposeBag)
        
        doingTableView.rx.modelDeleted(Task.self)
            .bind(onNext: { [weak self] in
                self?.taskListViewModel?.delete(task: $0) })
            .disposed(by: disposeBag)
        
        doneTableView.rx.modelDeleted(Task.self)
            .bind(onNext: { [weak self] in
                self?.taskListViewModel?.delete(task: $0) })
            .disposed(by: disposeBag)
    }
    
    private func setupHeaderViewsBinding() {
        taskListViewModel?.todoTasksCount
            .map { "\($0)" }
            .asDriver(onErrorJustReturn: "")
            .drive(todoTaskHeaderView.taskCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        taskListViewModel?.doingTasksCount
            .map { "\($0)" }
            .asDriver(onErrorJustReturn: "")
            .drive(doingTaskHeaderView.taskCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        taskListViewModel?.doneTasksCount
            .map { "\($0)" }
            .asDriver(onErrorJustReturn: "")
            .drive(doneTaskHeaderView.taskCountLabel.rx.text)
            .disposed(by: disposeBag)
    }
}

// MARK: - IBAction
extension TaskListViewController {
    @IBAction private func touchUpAddButton(_ sender: UIBarButtonItem) {
        taskListViewModel?.didTouchUpAddButton()
    }
}
