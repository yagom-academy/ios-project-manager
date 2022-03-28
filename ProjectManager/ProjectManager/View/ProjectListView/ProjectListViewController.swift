import UIKit
import RxCocoa
import RxSwift

final class ProjectListViewController: UIViewController {
    // MARK: - Property
    
    private let todoTableView = ProjectListTableView()
    private let doingTableView = ProjectListTableView()
    private let doneTableView = ProjectListTableView()
    private lazy var tableViews: [ProjectListTableView] = [todoTableView, doingTableView, doneTableView]
    private let headerViews = [ProjectListTableHeaderView(), ProjectListTableHeaderView(), ProjectListTableHeaderView()]
    private let longPressGestureRecognizers = [UILongPressGestureRecognizer(target: ProjectListViewController.self, action: nil),
                                               UILongPressGestureRecognizer(target: ProjectListViewController.self, action: nil),
                                               UILongPressGestureRecognizer(target: ProjectListViewController.self, action: nil)]
    private let changeStateList: [[ProjectState]] = [[.doing, .done], [.todo, .done], [.todo, .doing]]
    
    private let disposeBag = DisposeBag()
    private var viewModel: ProjectListViewModel?
    
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
        configureLongPressGesture()
        configureBind()
        cofigureNavigationItemBind()
        configureTableViewBind()
        configureGestureBind()
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
    
    private func configureGestureBind() {
        longPressGestureRecognizers.enumerated().forEach { index, gesture in
            gesture.rx.event
                .subscribe(onNext: { [weak self] event in
                    guard let stateToChange = self?.changeStateList[safe: index] else{
                        return
                    }
                    self?.handleLongPressGesture(event, moveTo: stateToChange)
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
        tableViews.enumerated().forEach { index, tableView in
            guard let gesture = longPressGestureRecognizers[safe: index] else {
                return
            }
            tableView.addGestureRecognizer(gesture)
        }
    }
    
    private func handleLongPressGesture(_ sender: UILongPressGestureRecognizer, moveTo state: [ProjectState]) {
        guard let (selectedProject, tableView, indexPath) = self.retrieveLongPressCell(gestureRecognizer: sender),
              let selectedProject = selectedProject else {
            return
        }
        
        guard let alert = createAlert(project: selectedProject,tableView: tableView, on: indexPath, moveTo: state) else {
            return
        }
        present(alert, animated: true)
    }
    
    private func retrieveLongPressCell(gestureRecognizer: UILongPressGestureRecognizer) -> (Project?, UITableView, IndexPath)? {
        guard let tableView = gestureRecognizer.view as? UITableView else {
            return nil
        }
        
        if gestureRecognizer.state == .began {
            let touchPoint = gestureRecognizer.location(in: tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                return (try? tableView.rx.model(at: indexPath), tableView, indexPath)
            }
        }
        return nil
    }
    
    private func createAlert(project: Project, tableView: UITableView, on indexPath: IndexPath, moveTo newState: [ProjectState]) -> UIAlertController? {
        guard let firstNewState = newState[safe: 0],
                let secondNewState = newState[safe: 1] else {
            return nil
        }
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let moveToFirstStateAction = UIAlertAction(title: firstNewState.alertActionTitle, style: .default) { _ in
            self.viewModel?.changeState(from: project, to: firstNewState)
        }
        let moveToSecondStateAction = UIAlertAction(title: secondNewState.alertActionTitle, style: .default) { _ in
            self.viewModel?.changeState(from: project, to: secondNewState)
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

