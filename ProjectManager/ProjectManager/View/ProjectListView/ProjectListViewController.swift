import UIKit

final class ProjectListViewController: UIViewController {
    // MARK: - Property
    
    private let todoTableView = ProjectListTableView()
    private let doingTableView = ProjectListTableView()
    private let doneTableView = ProjectListTableView()
    private var viewModel: ProjectListViewModel?
    private lazy var tableViews = [todoTableView, doingTableView, doneTableView]
    
    private let entireStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Design.entireStackViewSpacing
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .systemGray5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init(viewModel: ProjectListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
        configureBind()
        configureLongPressGesture()
    }
    
    private func configureUI() {
        self.view.backgroundColor = .systemBackground
        configureNavigationBar()
        configureEntireStackView()
        configureLayout()
    }
    
    private func configureNavigationBar() {
        self.navigationController?.isToolbarHidden = false
        self.navigationItem.title = TitleText.navigationBarTitle
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddProjectButton))
    }
    
    @objc private func didTapAddProjectButton() {
        guard let viewModel = viewModel else {
            return
        }
        let addProjectDetailViewModel = viewModel.createAddDetailViewModel()
        let viewController = AddProjectDetailViewController(viewModel: addProjectDetailViewModel, delegate: self)
        let destinationViewController = UINavigationController(rootViewController: viewController)

        destinationViewController.modalPresentationStyle = .formSheet
        present(destinationViewController, animated: true, completion: nil)
    }
    
    private func configureEntireStackView() {
        self.view.addSubview(entireStackView)
        tableViews.forEach {
            self.entireStackView.addArrangedSubview($0)
        }
    }

    private func configureLayout() {
        NSLayoutConstraint.activate([
            self.entireStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.entireStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.entireStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.entireStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        ])
    }
    
    private func configureTableView() {
        tableViews.forEach {
            $0.delegate = self
            $0.dataSource = self
            
            if #available(iOS 15, *) {
                $0.sectionHeaderTopPadding = Design.tableViewSectionHeaderTopPadding
            }
        }
    }
    
    private func configureBind() {
        viewModel?.fetchAll()
        
        viewModel?.onCellSelected = { [weak self] indexPath, project in
            guard let self = self, let viewModel = self.viewModel else {
                return
            }
            let editProjectDetailViewModel = viewModel.createEditDetailViewModel(indexPath: indexPath, state: project.state)
            let editViewController = EditProjectDetailViewController(viewModel: editProjectDetailViewModel, delegate: self)
            let destinationViewController = UINavigationController(rootViewController: editViewController)
            destinationViewController.modalPresentationStyle = .formSheet
            self.present(destinationViewController, animated: true, completion: nil)
        }
        
        viewModel?.onUpdated = {
            self.tableViews.forEach {
                $0.reloadData()
            }
        }
    }
    
    private func configureLongPressGesture() {
        let todoLongPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleTodoLongPressGesture))
        let doingLongPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleDoingLongPressGesture))
        let doneLongPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleDoneLongPressGesture))

        todoTableView.addGestureRecognizer(todoLongPressRecognizer)
        doingTableView.addGestureRecognizer(doingLongPressRecognizer)
        doneTableView.addGestureRecognizer(doneLongPressRecognizer)
    }
    
    @objc private func handleTodoLongPressGesture(sender: UILongPressGestureRecognizer) {
        handleLongPressGesture(sender, tableView: todoTableView, moveTo: [.doing, .done])
    }
    
    @objc private func handleDoingLongPressGesture(sender: UILongPressGestureRecognizer) {
        handleLongPressGesture(sender, tableView: doingTableView, moveTo: [.todo, .done])
    }
    
    @objc private func handleDoneLongPressGesture(sender: UILongPressGestureRecognizer) {
        handleLongPressGesture(sender, tableView: doneTableView, moveTo: [.todo, .doing])
    }
    
    private func handleLongPressGesture(_ sender: UILongPressGestureRecognizer, tableView: UITableView, moveTo state: [ProjectState]) {
        if sender.state == .began {
            let touchPoint = sender.location(in: tableView)

            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                guard let alert = createAlert(for: tableView, on: indexPath, moveTo: state) else {
                    return
                }
                present(alert, animated: true)
            }
        }
    }
    
    func state(of tableView: UITableView) -> ProjectState? {
        var state: ProjectState?
        switch tableView {
        case todoTableView:
            state = .todo
        case doingTableView:
            state = .doing
        case doneTableView:
            state = .done
        default:
            break
        }
        
        return state
    }
    
    private func createAlert(for tableView: UITableView, on indexPath: IndexPath, moveTo newState: [ProjectState]) -> UIAlertController? {
        guard let oldState = state(of: tableView),
                let firstNewState = newState[safe: 0],
                let secondNewState = newState[safe: 1] else {
            return nil
        }
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let moveToFirstStateAction = UIAlertAction(title: firstNewState.alertActionTitle, style: .default) { _ in
            self.viewModel?.changeState(from: oldState, to: firstNewState, indexPath: indexPath)
        }
        let moveToSecondStateAction = UIAlertAction(title: secondNewState.alertActionTitle, style: .default) { _ in
            self.viewModel?.changeState(from: oldState, to: secondNewState, indexPath: indexPath)
        }
        
        alert.addAction(moveToFirstStateAction)
        alert.addAction(moveToSecondStateAction)
        
        alert.popoverPresentationController?.sourceView = tableView.cellForRow(at: indexPath)
        alert.popoverPresentationController?.permittedArrowDirections = .up
        
        return alert
    }
    
}
// MARK: - UITableViewDelegate

extension ProjectListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Design.tableViewHeightForHeaderInSection
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let state = state(of: tableView) else {
            return nil
        }
        let numberOfProjects = viewModel?.numberOfProjects(state: state)
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withClass: ProjectListTableHeaderView.self)
        headerView.populateData(title: state.title, count: numberOfProjects ?? .zero)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { _, _, _ in
            guard let state = self.state(of: tableView) else {
                return
            }
            self.viewModel?.delete(indexPath: indexPath, state: state)
        }
        
        deleteAction.image = UIImage(systemName: "trash")
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let state = state(of: tableView) else {
            return
        }
        viewModel?.didSelectRow(indexPath: indexPath, state: state)
    }
}

extension ProjectListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let state = state(of: tableView) else {
            return .zero
        }
    
        switch state {
        case .todo:
            return viewModel?.todoProjects.count ?? 0
        case .doing:
            return viewModel?.doingProjects.count ?? 0
        case .done:
            return viewModel?.doneProjects.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let state = state(of: tableView),
              let project = viewModel?.retrieveSelectedData(indexPath: indexPath, state: state),
              let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else {
            return UITableViewCell()
        }

        let cell = tableView.dequeueReusableCell(withClass: ProjectListTableViewCell.self)
        if project.date < yesterday {
            cell.populateDataWithDate(title: project.title, body: project.body, date: project.date)
        } else {
            cell.populateData(title: project.title, body: project.body, date: project.date)
        }

        return cell
    }
}

//MARK: - Constants

private extension ProjectListViewController {
    enum TitleText {
        static let navigationBarTitle = "Project Manager"
    }

    enum Design {
        static let entireStackViewSpacing: CGFloat = 8
        static let tableViewSectionHeaderTopPadding: CGFloat = 1
        static let tableViewHeightForHeaderInSection: CGFloat = 50
    }
}

extension ProjectListViewController: ProjectDetailViewControllerDelegate {
    func didUpdateProject(_ project: Project) {
        viewModel?.update(project, state: nil)
    }
    
    func didAppendProject(_ project: Project) {
        viewModel?.append(project)
    }
}

