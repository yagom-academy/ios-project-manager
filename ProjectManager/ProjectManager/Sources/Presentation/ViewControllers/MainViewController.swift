import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    @IBOutlet private weak var todoTableView: UITableView!
    @IBOutlet private weak var doingTableView: UITableView!
    @IBOutlet private weak var doneTableView: UITableView!
    @IBOutlet private var tableViews: [UITableView]!
    @IBOutlet private weak var addButton: UIBarButtonItem!
    private let longPressGesture: [UILongPressGestureRecognizer] = ProjectState.allCases.map { _ in
        let longPressGesture = UILongPressGestureRecognizer()
        longPressGesture.minimumPressDuration = 0.5
        return longPressGesture
    }
    
    var viewModel: ProjectListViewModel?
    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        navigationItem.title = "Project Manager"
        setUpTableView()
        setUpBindings()
    }
    
    private func setUpTableView() {
        tableViews.enumerated().forEach { index, tableView in
            tableView.delegate = self
            tableView.addGestureRecognizer(self.longPressGesture[index])
            let cellNib = UINib(nibName: ProjectCell.nibName, bundle: .main)
            tableView.register(cellNib, forCellReuseIdentifier: ProjectCell.identifier)
            let headerNib = UINib(nibName: ProjectHeader.nibName, bundle: .main)
            tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: ProjectHeader.identifier)
            tableView.rx.itemSelected
                .subscribe(onNext: { tableView.deselectRow(at: $0, animated: true) }).disposed(by: bag)
        }
    }
    
    func setUpBindings() {
        let input = ProjectListViewModel.Input(
            didTapProjectCell: tableViews.map { $0.rx.itemSelected.map { $0.row } },
            didTapAddButton: addButton.rx.tap.asObservable(),
            didTapPopoverButton: longPressGesture.map {
                $0.rx.event
                    .map { (longPressGesture: UIGestureRecognizer) -> (UITableViewCell ,Project)? in
                        guard let tableView = longPressGesture.view as? UITableView else {
                            return nil
                        }
                        if longPressGesture.state == .began,
                           let indexPath = tableView.indexPathForRow(at: longPressGesture.location(in: tableView)),
                           let cell = tableView.cellForRow(at: indexPath) {
                                return (cell, try tableView.rx.model(at: indexPath))
                        }
                        return nil
                    }.asObservable()
            },
            didSwapeToTapDeleteButton: tableViews.map { $0.rx.modelDeleted(Project.self).asObservable() }
        )
        let output = viewModel?.transform(input: input)
        
        output?.projectList.enumerated().forEach { index, observable in
            let tableView = self.tableViews[index]
            observable.asDriver(onErrorJustReturn: [])
                .drive(
                    tableView.rx.items(cellIdentifier: ProjectCell.identifier, cellType: ProjectCell.self)
                ) { _, project, cell in
                    cell.configure(project)
            }
            .disposed(by: bag)
        }
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: ProjectHeader.identifier
        ) as? ProjectHeader else {
            return UIView()
        }
        switch tableView {
        case todoTableView:
            headerView.configure(
                title: ProjectState.todo.rawValue,
                count: viewModel?.projectList[ProjectState.todo.index].count ?? 0
            )
        case doingTableView:
            headerView.configure(
                title: ProjectState.doing.rawValue,
                count: viewModel?.projectList[ProjectState.doing.index].count ?? 0
            )
        case doneTableView:
            headerView.configure(
                title: ProjectState.done.rawValue,
                count: viewModel?.projectList[ProjectState.done.index].count ?? 0
            )
        default:
            break
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
}
