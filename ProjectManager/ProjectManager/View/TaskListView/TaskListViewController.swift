import UIKit
import RxSwift
import RxCocoa

final class TaskListViewController: UIViewController {
    // MARK: - Properties
    private var taskListViewModel: TaskListViewModelProtocol!
    private lazy var tableViews = [todoTableView, doingTableView, doneTableView]
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
        tableViews.forEach { tableView in
            tableView?.setupTableViewCell()
            tableView?.delegate = self
        }
        
        todoTableView.processStatus = .todo
        doingTableView.processStatus = .doing
        doneTableView.processStatus = .done
    }
    
    private func setupHeaderViews() {
        let todoTaskHeaderView = TaskTableHeaderView(reuseIdentifier: TaskTableHeaderView.reuseIdentifier,
                                                     taskCountObservable: taskListViewModel.todoTasksCount, // 기존 ViewModel의 일부 데이터를 생성자 주입으로 전달
                                                     processStatus: .todo)
        let doingTaskHeaderView = TaskTableHeaderView(reuseIdentifier: TaskTableHeaderView.reuseIdentifier,
                                                      taskCountObservable: taskListViewModel.doingTasksCount,
                                                      processStatus: .doing)
        let doneTaskHeaderView = TaskTableHeaderView(reuseIdentifier: TaskTableHeaderView.reuseIdentifier,
                                                     taskCountObservable: taskListViewModel.doneTasksCount,
                                                     processStatus: .done)

        todoTableView.tableHeaderView = todoTaskHeaderView
        doingTableView.tableHeaderView = doingTaskHeaderView
        doneTableView.tableHeaderView = doneTaskHeaderView
    }
    
    private func setupBindings() {
        setupTableViewsBinding()
    }
    
    private func setupTableViewsBinding() {
        taskListViewModel.todoTasksObservable?
            .asDriver(onErrorJustReturn: [])
            .drive(todoTableView.rx.items(cellIdentifier: TaskTableViewCell.reuseIdentifier,
                                          cellType: TaskTableViewCell.self)) { [weak self] _, task, cell in
                cell.setup(with: task, popoverPresenter: self!, viewModel: self!.taskListViewModel)
             }
             .disposed(by: disposeBag)
        
        taskListViewModel.doingTasksObservable?
            .asDriver(onErrorJustReturn: [])
            .drive(doingTableView.rx.items(cellIdentifier: TaskTableViewCell.reuseIdentifier,
                                           cellType: TaskTableViewCell.self)) { [weak self] _, task, cell in
                cell.setup(with: task, popoverPresenter: self!, viewModel: self!.taskListViewModel)
             }
             .disposed(by: disposeBag)

        taskListViewModel.doneTasksObservable?
            .asDriver(onErrorJustReturn: [])
            .drive(doneTableView.rx.items(cellIdentifier: TaskTableViewCell.reuseIdentifier,
                                          cellType: TaskTableViewCell.self)) { [weak self] _, task, cell in
                cell.setup(with: task, popoverPresenter: self!, viewModel: self!.taskListViewModel)
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
}
