import UIKit
import RxSwift
import RxCocoa

fileprivate enum Titles {
    static let todo = "TODO"
    static let doing = "DOING"
    static let done = "DONE"
    static let navigationItem = "Project Manager"
}

fileprivate enum Identifier {
    static let cellReuse = "task"
}

final class ProjectManagerViewController: UIViewController {
    
    // MARK: View
    
    private var todoTableView: UITableView = {
        let table = UITableView()
        table.register(TaskCell.self, forCellReuseIdentifier: Identifier.cellReuse)
        table.separatorStyle = .none
        table.backgroundColor = .systemGray6
        return table
    }()
    private var doingTableView: UITableView = {
        let table = UITableView()
        table.register(TaskCell.self, forCellReuseIdentifier: Identifier.cellReuse)
        table.separatorStyle = .none
        table.backgroundColor = .systemGray6
        return table
    }()
    private var doneTableView: UITableView = {
        let table = UITableView()
        table.register(TaskCell.self, forCellReuseIdentifier: Identifier.cellReuse)
        table.separatorStyle = .none
        table.backgroundColor = .systemGray6
        return table
    }()
    
    private var todoStatusView: TaskStatusInfoView = {
        let view = TaskStatusInfoView()
        view.setTitle(with: Titles.todo)
        view.backgroundColor = .systemGray6
        return view
    }()
    private var doingStatusView: TaskStatusInfoView = {
        let view = TaskStatusInfoView()
        view.setTitle(with: Titles.doing)
        view.backgroundColor = .systemGray6
        return view
    }()
    private var doneStatusView: TaskStatusInfoView = {
        let view = TaskStatusInfoView()
        view.setTitle(with: Titles.done)
        view.backgroundColor = .systemGray6
        return view
    }()
    
    private var todoStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        stack.axis = .vertical
        return stack
    }()
    private var doingStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        stack.axis = .vertical
        
        return stack
    }()
    private var doneStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        stack.axis = .vertical
        
        return stack
    }()
    
    private var wholeStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        return stack
    }()
    
    // MARK: ViewModel
    
    var viewModel: ProjectManagerViewModel?
    private let disposeBag = DisposeBag()
    
    // MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationController()
        configureView()
        combineViews()
        addTableviewLongPressRecognizers()
        
        bindViewModel()
        bindLongPressGesturesToTableViews()
        bindSelectionActionToCell()
    }
}

// MARK: Functions

extension ProjectManagerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ProjectManagerViewController: UIGestureRecognizerDelegate {
    private func addTableviewLongPressRecognizers() {
        let todoLongPressGesture = UILongPressGestureRecognizer()
        let todoLongPressAction = #selector(todoTableView.didLongPress)
        todoLongPressGesture.addTarget(todoTableView, action: todoLongPressAction)
        
        let doingLongPressGesture = UILongPressGestureRecognizer()
        let doingLongPressAction = #selector(doingTableView.didLongPress)
        doingLongPressGesture.addTarget(doingTableView, action: doingLongPressAction)
        
        let doneLongPressGesture = UILongPressGestureRecognizer()
        let doneLongPressAction =  #selector(doingTableView.didLongPress)
        doneLongPressGesture.addTarget(doneTableView, action: doneLongPressAction)
        
        todoTableView.addGestureRecognizer(todoLongPressGesture)
        doingTableView.addGestureRecognizer(doingLongPressGesture)
        doneTableView.addGestureRecognizer(doneLongPressGesture)
        
        todoLongPressGesture.delegate = todoTableView
        doingLongPressGesture.delegate = doingTableView
        doneLongPressGesture.delegate = doneTableView
    }
}

extension ProjectManagerViewController {
    
    private func configureNavigationController() {
        let rightAddButton = UIBarButtonItem(barButtonSystemItem: .add, target: self,
                                             action: #selector(tapNavigationAddButton))
        navigationItem.rightBarButtonItem = rightAddButton
        navigationItem.title = Titles.navigationItem
        
    }
    
    private func configureView() {
        self.view.backgroundColor = UIColor.systemGray3
    }
    
    @objc
    private func tapNavigationAddButton() {
        let addTaskView = AddTaskViewController()
        addTaskView.modalPresentationStyle = .formSheet
        let useCase = TaskItemsUseCase(datasource: MemoryDataSource.shared)
        addTaskView.viewmodel = AddTaskViewModel(useCase: useCase)
        let navigation = UINavigationController(rootViewController: addTaskView)
        self.present(navigation, animated: true)
    }
    
    private func presentTaskTagSwitcher(task: Task, on view: UIView) {
        let switcher = SwitchTaskViewController()
        switcher.sourceView(view: view)
        let useCase = TaskItemsUseCase(datasource: MemoryDataSource.shared)
        let viewModel = SwitchTaskViewModel(useCase: useCase, task: task)
        switcher.viewModel = viewModel
        
        self.present(switcher, animated: true)
    }
    
    private func createEditView(with item: TaskItemViewModel) -> UINavigationController {
        let editView = EditTaskViewController()
        let useCase = TaskItemsUseCase(datasource: MemoryDataSource.shared)
        editView.viewModel = EditTaskViewModel(item: item, useCase: useCase)
        let navigation = UINavigationController(rootViewController: editView)
        return navigation
    }
}

// MARK: Bindings

extension ProjectManagerViewController {
    
    // MARK: Long Press Gesture
    
    private func bindLongPressGesturesToTableViews() {
        todoTableView.rx
            .methodInvoked(#selector(todoTableView.didLongPress))
            .withLatestFrom(self.todoTableView.rx.itemSelected)
            .subscribe(onNext: { index in
                if let cell = self.todoTableView.cellForRow(at: index) as? TaskCell,
                   let viewModel = cell.viewModel {
                    self.presentTaskTagSwitcher(task: viewModel.task, on: cell)
                }
            })
            .disposed(by: disposeBag)
        
        doingTableView.rx
            .methodInvoked(#selector(doingTableView.didLongPress))
            .withLatestFrom(doingTableView.rx.itemSelected)
            .subscribe(onNext: { index in
                if let cell = self.doingTableView.cellForRow(at: index) as? TaskCell,
                   let viewModel = cell.viewModel {
                    self.presentTaskTagSwitcher(task: viewModel.task, on: cell)
                }
            })
            .disposed(by: disposeBag)
        
        doneTableView.rx
            .methodInvoked(#selector(doneTableView.didLongPress))
            .withLatestFrom(doneTableView.rx.itemSelected)
            .subscribe(onNext: { index in
                if let cell = self.doneTableView.cellForRow(at: index) as? TaskCell,
                   let viewModel = cell.viewModel {
                    self.presentTaskTagSwitcher(task: viewModel.task, on: cell)
                }
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: Cell Action
    
    private func bindSelectionActionToCell() {
        self.todoTableView.rx
            .modelSelected(TaskItemViewModel.self)
            .subscribe(onNext: { item in
                let view = self.createEditView(with: item)
                self.present(view, animated: true)
            })
            .disposed(by: disposeBag)
        
        self.doingTableView.rx
            .modelSelected(TaskItemViewModel.self)
            .subscribe(onNext: { item in
                let view = self.createEditView(with: item)
                self.present(view, animated: true)
            })
            .disposed(by: disposeBag)
        
        self.doneTableView.rx
            .modelSelected(TaskItemViewModel.self)
            .subscribe(onNext: { item in
                let view = self.createEditView(with: item)
                self.present(view, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func bindViewModel() {
        guard let viewModel = self.viewModel else { return }
        
        let todoDeleted = todoTableView.rx
            .modelDeleted(TaskItemViewModel.self)
            .asObservable()
        let doingDeleted = doingTableView.rx
            .modelDeleted(TaskItemViewModel.self)
            .asObservable()
        let doneDeleted = doneTableView.rx
            .modelDeleted(TaskItemViewModel.self)
            .asObservable()
        
        let deletedTrigger = Observable.merge(todoDeleted, doingDeleted, doneDeleted)
        
        let updateTrigger = self.rx
            .methodInvoked(#selector(UIViewController.viewWillAppear(_:)))
            .map { _ in }
        
        let input = ProjectManagerViewModel.Input(update: updateTrigger,
                                                  delete: deletedTrigger)
        let output = viewModel.transform(input: input)
        
        // MARK: Delete Output
        
        output.deletedItem
            .subscribe()
            .disposed(by: disposeBag)
        
        // MARK: Status View
        
        output.todoItems
            .map { $0.count }
            .subscribe(onNext: { count in
                self.todoStatusView.setUpCount(count: count)
            })
            .disposed(by: disposeBag)
        
        output.doingItems
            .map { $0.count }
            .subscribe(onNext: { count in
                self.doingStatusView.setUpCount(count: count)
            })
            .disposed(by: disposeBag)
        
        output.doneItems
            .map { $0.count }
            .subscribe(onNext: { count in
                self.doneStatusView.setUpCount(count: count)
            })
            .disposed(by: disposeBag)
        
        // MARK: Table View Cell
        
        output.todoItems
            .bind(to: self.todoTableView.rx.items) { (tableview, index, item) in
                guard let cell = tableview.dequeueReusableCell(withIdentifier:
                                                                Identifier.cellReuse)
                        as? TaskCell
                else { return TaskCell() }
                cell.viewModel = item
                cell.setupUsingViewModel()
                return cell
            }
            .disposed(by: disposeBag)
        
        output.doingItems
            .bind(to: self.doingTableView.rx.items) { (tableview, index, item) in
                guard let cell = tableview.dequeueReusableCell(withIdentifier:
                                                                Identifier.cellReuse)
                        as? TaskCell
                else { return TaskCell() }
                cell.viewModel = item
                cell.setupUsingViewModel()
                return cell
            }
            .disposed(by: disposeBag)
        
        output.doneItems
            .bind(to: self.doneTableView.rx.items) { (tableview, index, item) in
                guard let cell = tableview.dequeueReusableCell(withIdentifier:
                                                                Identifier.cellReuse)
                        as? TaskCell
                else { return TaskCell() }
                cell.viewModel = item
                cell.setupUsingViewModel()
                return cell
            }
            .disposed(by: disposeBag)
    }
}

// MARK: Layout
extension ProjectManagerViewController {
    private func combineViews() {
        todoStackView.addArrangedSubview(todoStatusView)
        todoStackView.addArrangedSubview(todoTableView)
        
        doingStackView.addArrangedSubview(doingStatusView)
        doingStackView.addArrangedSubview(doingTableView)
        
        doneStackView.addArrangedSubview(doneStatusView)
        doneStackView.addArrangedSubview(doneTableView)
        
        wholeStackView.addArrangedSubview(todoStackView)
        wholeStackView.addArrangedSubview(doingStackView)
        wholeStackView.addArrangedSubview(doneStackView)
        
        self.view.addSubview(wholeStackView)
        
        NSLayoutConstraint.activate([
            wholeStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            wholeStackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            wholeStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            wholeStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
}
