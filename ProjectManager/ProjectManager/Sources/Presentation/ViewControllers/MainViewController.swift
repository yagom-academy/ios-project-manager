import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    @IBOutlet private weak var todoTableView: UITableView!
    @IBOutlet private weak var doingTableView: UITableView!
    @IBOutlet private weak var doneTableView: UITableView!
    @IBOutlet private var tableViews: [UITableView]!
    @IBOutlet private weak var addButton: UIBarButtonItem!
    let viewModel = ProjectListViewModel()
    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        navigationItem.title = "Project Manager"
        configureTableView()
    }
    
    private func configureTableView() {
        tableViews.forEach { tableView in
            tableView.dataSource = self
            tableView.delegate = self
            let cellNib = UINib(nibName: "ProjectCell", bundle: .main)
            tableView.register(cellNib, forCellReuseIdentifier: "projectCell")
            let headerNib = UINib(nibName: "ProjectHeader", bundle: .main)
            tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "projectHeader")
            tableView.sectionHeaderHeight = 1
        }
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "projectCell", for: indexPath) as? ProjectCell else {
            return UITableViewCell()
        }
        return cell
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
                count: viewModel.projectList[ProjectState.todo.index].count
            )
        case doingTableView:
            headerView.configure(
                title: ProjectState.doing.rawValue,
                count: viewModel.projectList[ProjectState.doing.index].count
            )
        case doneTableView:
            headerView.configure(
                title: ProjectState.done.rawValue,
                count: viewModel.projectList[ProjectState.done.index].count
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
