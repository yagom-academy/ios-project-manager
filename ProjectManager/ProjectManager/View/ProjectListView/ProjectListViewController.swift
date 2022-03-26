import UIKit
import RxCocoa
import RxSwift

final class ProjectListViewController: UIViewController {
    // MARK: - Property
    
    private let todoTableView = ProjectListTableView()
    private let doingTableView = ProjectListTableView()
    private let doneTableView = ProjectListTableView()
    private var viewModel: ProjectListViewModel?
    private lazy var tableViews: [ProjectListTableView] = [todoTableView, doingTableView, doneTableView]
    private let headerViews = [ProjectListTableHeaderView(), ProjectListTableHeaderView(), ProjectListTableHeaderView()]
    
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
    
    private let addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: ProjectListViewController.self, action: nil)
        return button
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
        cofigureNavigationItemBind()
        configureTableViewBind()
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
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    private func configureBind() {
        let input = ProjectListViewModel.Input()
        
        let output = self.viewModel?.transform(input: input)
        
        output?.todoProjects
            .do(onNext: { [weak self] in
                (self?.todoTableView.tableHeaderView as? ProjectListTableHeaderView)?.populateData(title: $0.first?.state.title ?? "TODO",  count: $0.count)
            })
            .asDriver(onErrorJustReturn: [])
            .drive(
                todoTableView.rx.items(
                    cellIdentifier: String(describing: ProjectListTableViewCell.self),
                    cellType: ProjectListTableViewCell.self)
            ) { _, item, cell in
                guard let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else { return }
                if item.date < yesterday {
                    cell.populateDataWithDate(title: item.title, body: item.body, date: item.date)
                } else {
                    cell.populateData(title: item.title, body: item.body, date: item.date)
                }
            }.disposed(by: disposeBag)

        output?.doingProjects
            .do(onNext: { [weak self] in
                (self?.doingTableView.tableHeaderView as? ProjectListTableHeaderView)?.populateData(title: $0.first?.state.title ?? "DOING", count: $0.count)
            })
            .asDriver(onErrorJustReturn: [])
            .drive(
                doingTableView.rx.items(
                    cellIdentifier: String(describing: ProjectListTableViewCell.self),
                    cellType: ProjectListTableViewCell.self)
            ) { _, item, cell in
                guard let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else { return }
                if item.date < yesterday {
                    cell.populateDataWithDate(title: item.title, body: item.body, date: item.date)
                } else {
                    cell.populateData(title: item.title, body: item.body, date: item.date)
                }
            }.disposed(by: disposeBag)

        output?.doneProjects
            .do(onNext: { [weak self] in
                (self?.doneTableView.tableHeaderView as? ProjectListTableHeaderView)?.populateData(title: $0.first?.state.title ?? "DONE", count: $0.count)
            })
            .asDriver(onErrorJustReturn: [])
            .drive(
                doneTableView.rx.items(
                    cellIdentifier: String(describing: ProjectListTableViewCell.self),
                    cellType: ProjectListTableViewCell.self)
            ) { _, item, cell in
                guard let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else { return }
                if item.date < yesterday {
                    cell.populateDataWithDate(title: item.title, body: item.body, date: item.date)
                } else {
                    cell.populateData(title: item.title, body: item.body, date: item.date)
                }
            }.disposed(by: disposeBag)
    }
    
    private func cofigureNavigationItemBind() {
        addButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let viewModel = self?.viewModel else {
                    return
                }
                let addProjectDetailViewModel = viewModel.createAddDetailViewModel()
                let viewController = AddProjectDetailViewController(viewModel: addProjectDetailViewModel)
                let destinationViewController = UINavigationController(rootViewController: viewController)

                destinationViewController.modalPresentationStyle = .formSheet
                self?.present(destinationViewController, animated: true, completion: nil)
            }).disposed(by: disposeBag)
    }
    
    private func configureTableViewBind() {
        tableViews.forEach {
            $0.rx.modelSelected(Project.self)
                .subscribe(onNext: { [weak self] project in
                    guard let viewModel = self?.viewModel else {
                        return
                    }
                    let editProjectDetailViewModel = viewModel.createEditDetailViewModel(with: project)
                    let viewController = EditProjectDetailViewController(viewModel: editProjectDetailViewModel)
                    let destinationViewController = UINavigationController(rootViewController: viewController)
                    
                    destinationViewController.modalPresentationStyle = .formSheet
                    self?.present(destinationViewController, animated: true, completion: nil)
                }).disposed(by: disposeBag)
        }
        
        tableViews.forEach {
            $0.rx.modelDeleted(Project.self)
                .subscribe(onNext: { [weak self] project in
                    self?.viewModel?.delete(project: project)
                }).disposed(by: disposeBag)
        }
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
        tableViews.enumerated().forEach { index, tableView in
            tableView.tableHeaderView = headerViews[safe: index]
            tableView.tableHeaderView?.frame.size.height = Design.tableViewHeightForHeaderInSection
            if #available(iOS 15, *) {
                tableView.sectionHeaderTopPadding = Design.tableViewSectionHeaderTopPadding
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

