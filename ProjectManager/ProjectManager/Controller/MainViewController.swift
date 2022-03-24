import UIKit
import RxSwift

class MainViewController: UIViewController {
    private let viewModel = MainViewModel()
    private let moveToToDoObserver: PublishSubject<CellInformation> = .init()
    private let moveToDoingObserver: PublishSubject<CellInformation> = .init()
    private let moveToDoneObserver: PublishSubject<CellInformation> = .init()
    private let selectObserver: PublishSubject<Project> = .init()
    private let deleteObserver: PublishSubject<Project> = .init()
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
        let input = MainViewModel.Input(
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
        let viewModel = viewModel.makeAddProjectViewModel()
        let viewController = AddProjectViewController(viewModel: viewModel)
        viewController.modalPresentationStyle = .formSheet
        present(viewController, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func projects(for tableView: UITableView) ->[Project] {
        switch tableView {
        case toDoTableView:
            return viewModel.todoProjects
        case doingTableView:
            return viewModel.doingProjects
        case doneTableView:
            return viewModel.doneProjects
        default:
            return []
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects(for: tableView).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(ProjectListCell.self, for: indexPath) else {
            return UITableViewCell()
        }
        let projects = projects(for: tableView)
        cell.setupCell(of: indexPath, with: projects[indexPath.row])
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedProject = projects(for: tableView)[indexPath.row]
        selectObserver.onNext(selectedProject)
        let viewModel = viewModel.makeEditProjectViewModel()
        let viewController = EditProjectViewController(viewModel: viewModel)
        viewController.modalPresentationStyle = .formSheet
        viewController.setupEditView(with: selectedProject)
        viewController.actionAfterDismiss = deselectCell
        present(viewController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let selectedProject = projects(for: tableView)[indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: Text.deleteActionTitle) { _, _, _  in
            self.deleteObserver.onNext(selectedProject)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

// MARK: - ProjectListCellDelegate

extension MainViewController: ProjectListCellDelegate {
    func didTapTodoAction(_ state: ProjectState?, indexPath: IndexPath?) {
        guard let state = state,
              let indexPath = indexPath else { return }
        let cellInformation = (state, indexPath)
        moveToToDoObserver.onNext(cellInformation)
    }
    
    func didTapDoingAction(_ state: ProjectState?, indexPath: IndexPath?) {
        guard let state = state,
              let indexPath = indexPath else { return }
        let cellInformation = (state, indexPath)
        moveToDoingObserver.onNext(cellInformation)
    }
    
    func didTapDoneAction(_ state: ProjectState?, indexPath: IndexPath?) {
        guard let state = state,
              let indexPath = indexPath else { return }
        let cellInformation = (state, indexPath)
        moveToDoneObserver.onNext(cellInformation)
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
