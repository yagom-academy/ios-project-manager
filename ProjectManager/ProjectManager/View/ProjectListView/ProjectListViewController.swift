import UIKit
import RxSwift
import RxCocoa

final class ProjectListViewController: UIViewController {
    // MARK: - Property
    
    private let todoTableView = ProjectListTableView(state: .todo)
    private let doingTableView = ProjectListTableView(state: .doing)
    private let doneTableView = ProjectListTableView(state: .done)
    private var viewModel: ProjectListViewModel?
    private lazy var tableViews = [todoTableView, doingTableView, doneTableView]
    
    private let selectCellObservable: PublishSubject<(ProjectState, IndexPath)> = PublishSubject<(ProjectState, IndexPath)>()
    private let changeStateObservable: PublishSubject<Project> = PublishSubject<Project>()
    private let deleteObservable: PublishSubject<Project> = PublishSubject<Project>()
    private let disposeBag = DisposeBag()
    
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
            $0.dataSource = viewModel
            
            if #available(iOS 15, *) {
                $0.sectionHeaderTopPadding = Design.tableViewSectionHeaderTopPadding
            }
        }
    }
    
    private func configureBind() {
        viewModel?.fetchAll()
        
        let input = ProjectListViewModel.Input(
            selectCellObservable: self.selectCellObservable.asObservable(),
            changeStateObservable: self.changeStateObservable.asObservable(),
            deleteObservable: self.deleteObservable.asObservable()
        )
        
        guard let output = viewModel?.transform(input) else {
            return
        }
        
        output
            .showsEditViewControllerObservable
            .subscribe(onNext: { [weak self] viewModel in
                guard let self = self else {
                    return
                }
                
                let editViewController = EditProjectDetailViewController(viewModel: viewModel, delegate: self)
                let destinationViewController = UINavigationController(rootViewController: editViewController)
                destinationViewController.modalPresentationStyle = .formSheet
                self.present(destinationViewController, animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        output
            .reloadObservable
            .subscribe(onNext: { [weak self] _ in
                self?.tableViews.forEach {
                    $0.reloadData()
                }
            }).disposed(by: disposeBag)
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
    
    private func createAlert(for tableView: UITableView, on indexPath: IndexPath, moveTo newState: [ProjectState]) -> UIAlertController? {
        guard let oldState = ((tableView as? ProjectListTableView)?.state),
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
        guard let state = (tableView as? ProjectListTableView)?.state else {
            return UIView()
        }
        let numberOfProjects = viewModel?.numberOfProjects(state: state)
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withClass: ProjectListTableHeaderView.self)
        headerView.populateData(title: state.title, count: numberOfProjects ?? .zero)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { _, _, _ in
            guard let state = (tableView as? ProjectListTableView)?.state else {
                return
            }
            self.viewModel?.delete(indexPath: indexPath, state: state)
        }
        
        deleteAction.image = UIImage(systemName: "trash")
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let state = (tableView as? ProjectListTableView)?.state else {
            return
        }
        self.selectCellObservable.onNext((state, indexPath))
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

