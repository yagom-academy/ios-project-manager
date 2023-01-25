import UIKit
import RxSwift
import RxCocoa

fileprivate enum Common {
    static let todo = "TODO"
    static let doing = "DOING"
    static let done = "DONE"
    static let cellReuseIdentifier = "task"
    static let navigationItemTitle = "Project Manager"
}

final class ProjectManagerViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: View
    
    var todoTableView: UITableView = {
        let table = UITableView()
        table.register(TaskCell.self, forCellReuseIdentifier: Common.cellReuseIdentifier)
        table.separatorStyle = .none
        table.backgroundColor = .systemGray6
        return table
    }()
    var doingTableView: UITableView = {
        let table = UITableView()
        table.register(TaskCell.self, forCellReuseIdentifier: Common.cellReuseIdentifier)
        table.separatorStyle = .none
        table.backgroundColor = .systemGray6
        return table
    }()
    var doneTableView: UITableView = {
        let table = UITableView()
        table.register(TaskCell.self, forCellReuseIdentifier: Common.cellReuseIdentifier)
        table.separatorStyle = .none
        table.backgroundColor = .systemGray6
        return table
    }()
    
    var todoStatusView: TaskStatusView = {
        let view = TaskStatusView()
        view.taskNameLabel.text = Common.todo
        view.backgroundColor = .systemGray6
        return view
    }()
    var doingStatusView: TaskStatusView = {
        let view = TaskStatusView()
        view.taskNameLabel.text = Common.doing
        view.backgroundColor = .systemGray6
        return view
    }()
    var doneStatusView: TaskStatusView = {
        let view = TaskStatusView()
        view.taskNameLabel.text = Common.done
        view.backgroundColor = .systemGray6
        return view
    }()
    
    var todoStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        stack.axis = .vertical
        return stack
    }()
    var doingStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        stack.axis = .vertical
        
        return stack
    }()
    var doneStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        stack.axis = .vertical
        
        return stack
    }()
    
    var wholeStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        return stack
    }()
    
    // MARK: ViewModel
    var viewModel: ProjectManagerViewModel?
    let disposeBag = DisposeBag()
    
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
    
    private func presentTaskTagSwitcher(task: Task, on view: UIView) {
        let switcher = TaskSwitchViewController()
        switcher.asPopover()
        switcher.sourceView(view: view)
        let useCase = TaskItemsUseCase(datasource: MemoryDataSource.shared)
        let viewModel = TaskSwitchViewModel(useCase: useCase, task: task)
        switcher.viewModel = viewModel
        
        self.present(switcher, animated: true)
    }
    
    private func configureNavigationController() {
        if let navigationController = self.navigationController {
            let navigationBar = navigationController.navigationBar
//            navigationBar.backgroundColor = UIColor.systemGray
            let rightAddButton = UIBarButtonItem(barButtonSystemItem: .add, target: self,
                                                 action: #selector(tapNavigationAddButton))
            navigationItem.rightBarButtonItem = rightAddButton
            navigationItem.title = Common.navigationItemTitle
        }
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

    private func popOver(cell: UITableViewCell, item: Task) {
        let view = TaskSwitchViewController()
        view.sourceView(view: cell)
        self.present(view, animated: true)
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
        
        let updateTrigger = self.rx
                    .methodInvoked(#selector(UIViewController.viewWillAppear(_:)))
                    .map { _ in }

                let input = ProjectManagerViewModel.Input(update: updateTrigger)
                let output = viewModel.transform(input: input)

                // MARK: Status View
                
                output.todoItems
                    .map { String($0.count) }
                    .bind(to: self.todoStatusView.taskCountLabel.rx.text)
                    .disposed(by: disposeBag)

                output.doingItems
                    .map { String($0.count) }
                    .bind(to: self.doingStatusView.taskCountLabel.rx.text)
                    .disposed(by: disposeBag)

                output.doneItems
                    .map { String($0.count) }
                    .bind(to: self.doneStatusView.taskCountLabel.rx.text)
                    .disposed(by: disposeBag)

                // MARK: Table View Cell
                
                output.todoItems
                    .bind(to: self.todoTableView.rx.items) { (tableview, index, item) in
                        guard let cell = tableview.dequeueReusableCell(withIdentifier:
                                                                        Common.cellReuseIdentifier)
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
                                                                        Common.cellReuseIdentifier)
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
                                                                        Common.cellReuseIdentifier)
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
