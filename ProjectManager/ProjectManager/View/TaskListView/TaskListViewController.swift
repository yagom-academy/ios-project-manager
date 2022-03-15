import UIKit
import RxSwift
import RxCocoa

final class TaskListViewController: UIViewController {
    // MARK: - Properties
    private var taskListViewModel: TaskListViewModelProtocol!
    private lazy var tableViews = [todoTableView, doingTableView, doneTableView]
    
    var disposeBag = DisposeBag()
    
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
            let nib = UINib(nibName: TaskTableViewCell.reuseIdentifier, bundle: nil)
            tableView?.register(nib, forCellReuseIdentifier: TaskTableViewCell.reuseIdentifier)
        }
    }
    
    private func setupBindings() {
        setupTableViewsBinding()
        
        // TODO: todoTableView.rx.didSelectItem 활용해보기
        // TODO: todoTableView.rx.tableHeaderView 활용해보기
    }
    
    private func setupTableViewsBinding() {
        taskListViewModel.todoTasksObservable?
            .asDriver(onErrorJustReturn: [])
            .drive(todoTableView.rx.items(cellIdentifier: TaskTableViewCell.reuseIdentifier,
                                          cellType: TaskTableViewCell.self)) { _, task, cell in
                cell.applyDate(with: task)
             }
             .disposed(by: disposeBag)
        
        taskListViewModel.doingTasksObservable?
            .asDriver(onErrorJustReturn: [])
            .drive(doingTableView.rx.items(cellIdentifier: TaskTableViewCell.reuseIdentifier,
                                          cellType: TaskTableViewCell.self)) { _, task, cell in
                cell.applyDate(with: task)
             }
             .disposed(by: disposeBag)

        taskListViewModel.doneTasksObservable?
            .asDriver(onErrorJustReturn: [])
            .drive(doneTableView.rx.items(cellIdentifier: TaskTableViewCell.reuseIdentifier,
                                          cellType: TaskTableViewCell.self)) { _, task, cell in
                cell.applyDate(with: task)
             }
             .disposed(by: disposeBag)
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

// MARK: - TableView Delegate
//extension TaskListViewController: UITableViewDelegate {
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
//}

// MARK: - TableView Header
extension TaskListViewController {
    // TODO: Custom HeaderView 추가
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let tableView = tableView as? TaskTableView else {
            print(TableViewError.invalidTableView)
            return ""
        }
        
        var title: String?
        _ = taskListViewModel.titleForHeaderInSection(for: tableView)
            .subscribe(onNext: {
                title = $0.description
            })
            .disposed(by: disposeBag)
        
        return title
    }
}
