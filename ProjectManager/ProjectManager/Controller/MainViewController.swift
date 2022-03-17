import UIKit
import RxSwift

class MainViewController: UIViewController {
    private let viewModel = ProjectViewModel()
    private let moveToToDoObserver: PublishSubject<Project> = .init()
    private let moveToDoingObserver: PublishSubject<Project> = .init()
    private let moveToDoneObserver: PublishSubject<Project> = .init()
    private let selectObserver = PublishSubject<Project>.init()
    private let deleteObserver = PublishSubject<Project>.init()
    private let disposeBag: DisposeBag = .init()
    
    private let toDoTableView = UITableView()
    private let doingTableView = UITableView()
    private let doneTableView = UITableView()
    
    private let toDoHeader = ProjectListHeaderView(title: ProjectState.todo.title)
    private let doingHeader = ProjectListHeaderView(title: ProjectState.doing.title)
    private let doneHeader = ProjectListHeaderView(title: ProjectState.done.title)
    
    private lazy var toDoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [toDoHeader, toDoTableView])
        stackView.axis = .vertical
        toDoHeader.heightAnchor.constraint(equalToConstant: Design.tableViewHeaderHeight).isActive = true
        stackView.distribution = .fill
        toDoTableView.backgroundColor = .secondarySystemBackground
        
        return stackView
    }()
    
    private lazy var doingStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [doingHeader, doingTableView])
        stackView.axis = .vertical
        doingHeader.heightAnchor.constraint(equalToConstant: Design.tableViewHeaderHeight).isActive = true
        stackView.distribution = .fill
        doingTableView.backgroundColor = .secondarySystemBackground
        
        return stackView
    }()
    
    private lazy var doneStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [doneHeader, doneTableView])
        stackView.axis = .vertical
        doneHeader.heightAnchor.constraint(equalToConstant: Design.tableViewHeaderHeight).isActive = true
        stackView.distribution = .fill
        doneTableView.backgroundColor = .secondarySystemBackground
        
        return stackView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [toDoStackView, doingStackView, doneStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.spacing = Design.mainStackViewSpacing
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .systemGray3
        
        return stackView
    }()
    
    private lazy var deselectCell = {
        if let toDoIndex = self.toDoTableView.indexPathForSelectedRow {
            self.toDoTableView.deselectRow(at: toDoIndex, animated: true)
        }
        if let doingIndex = self.doingTableView.indexPathForSelectedRow {
            self.doingTableView.deselectRow(at: doingIndex, animated: true)
        }
        if let doneIndex = self.doneTableView.indexPathForSelectedRow {
            self.doneTableView.deselectRow(at: doneIndex, animated: true)
        }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        bind()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        bind()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBar()
        setupStackViewLayout()
        registerProjectListCell()
    }
    
    func bind() {
        let input = ProjectViewModel.Input(
            moveToToDoObserver: moveToToDoObserver.asObservable(),
            moveToDoingObserver: moveToDoingObserver.asObservable(),
            moveToDoneObserver: moveToDoneObserver.asObservable(),
            selectObserver: selectObserver.asObservable(),
            deleteObserver: deleteObserver.asObservable()
        )
        
        let output = viewModel.transform(input)
        
        output
            .reloadObserver
            .subscribe(onNext: { [weak self] in
                self?.reloadTableView()
            })
            .disposed(by: disposeBag)
    }
    
    private func reloadTableView() {
        toDoTableView.reloadData()
        doingTableView.reloadData()
        doneTableView.reloadData()
        toDoHeader.updateProjectCount(viewModel.todoProjects.count)
        doingHeader.updateProjectCount(viewModel.doingProjects.count)
        doneHeader.updateProjectCount(viewModel.doneProjects.count)
    }
    
    private func setupStackViewLayout() {
        view.addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            toDoStackView.heightAnchor.constraint(equalTo: mainStackView.heightAnchor),
            doingStackView.heightAnchor.constraint(equalTo: mainStackView.heightAnchor),
            doneStackView.heightAnchor.constraint(equalTo: mainStackView.heightAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddProjectView))
        navigationItem.title = Text.navigationTitle
        navigationItem.rightBarButtonItem = addButton
    }
    
    private func setupTableView() {
        toDoTableView.delegate = self
        doingTableView.delegate = self
        doneTableView.delegate = self
        toDoTableView.dataSource = self
        doingTableView.dataSource = self
        doneTableView.dataSource = self
    }
    
    private func registerProjectListCell() {
        toDoTableView.register(ProjectListCell.self)
        doingTableView.register(ProjectListCell.self)
        doneTableView.register(ProjectListCell.self)
    }
    
    @objc private func showAddProjectView() {
        let viewController = AddProjectViewController()
        viewController.modalPresentationStyle = .formSheet
        viewController.viewModel = viewModel
        present(viewController, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case toDoTableView:
            return viewModel.todoProjects.count
        case doingTableView:
            return viewModel.doingProjects.count
        case doneTableView:
            return viewModel.doneProjects.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(ProjectListCell.self, for: indexPath) else {
            return UITableViewCell()
        }
        switch tableView {
        case toDoTableView:
            let project = viewModel.todoProjects[indexPath.row]
            cell.setupCell(with: project)
            cell.delegate = self
            return cell
        case doingTableView:
            let project = viewModel.doingProjects[indexPath.row]
            cell.setupCell(with: project)
            cell.delegate = self
            return cell
        case doneTableView:
            let project = viewModel.doneProjects[indexPath.row]
            cell.setupCell(with: project)
            cell.delegate = self
            return cell
        default:
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? ProjectListCell,
        let selectedProject = cell.project else { return }
        selectObserver.onNext(selectedProject)
        let viewController = EditProjectViewController()
        viewController.modalPresentationStyle = .formSheet
        viewController.viewModel = viewModel
        viewController.setupEditView(with: selectedProject)
        viewController.actionAfterDismiss = deselectCell
        present(viewController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let cell = tableView.cellForRow(at: indexPath) as? ProjectListCell,
        let selectedProject = cell.project else { return nil }
        let deleteAction = UIContextualAction(style: .destructive, title: Text.deleteActionTitle) { _, _, _  in
            self.deleteObserver.onNext(selectedProject)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

// MARK: - ProjectListCellDelegate

extension MainViewController: ProjectListCellDelegate {
    func didTapTodoAction(_ project: Project?) {
        guard let project = project else { return }
        moveToToDoObserver.onNext(project)
    }
    
    func didTapDoingAction(_ project: Project?) {
        guard let project = project else { return }
        moveToDoingObserver.onNext(project)
    }
    
    func didTapDoneAction(_ project: Project?) {
        guard let project = project else { return }
        moveToDoneObserver.onNext(project)
    }
    
    func presentPopover(_ alert: UIAlertController) {
        present(alert, animated: true)
    }
}

private enum Text {
    static let navigationTitle = "Project Manager"
    static let deleteActionTitle = "Delete"
    
}

private enum Design {
    static let tableViewHeaderHeight: CGFloat = 55
    static let mainStackViewSpacing: CGFloat = 5
}
