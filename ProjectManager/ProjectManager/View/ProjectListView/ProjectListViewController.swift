import UIKit

class ProjectListViewController: UIViewController {
    private let todoTableView = ProjectListTableView()
    private let doingTableView = ProjectListTableView()
    private let doneTableView = ProjectListTableView()
    private var viewModel: ProjectViewModel?
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

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
        configureBind()
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
        let viewController = AddProjectDetailViewController()
        let destinationViewController = UINavigationController(rootViewController: viewController)

        destinationViewController.modalPresentationStyle = .formSheet
        present(destinationViewController, animated: true, completion: nil)
    }
    
    private func configureTableView() {
        configureDataSource()
        tableViews.forEach {
            $0.delegate = self
            $0.dataSource = viewModel
            
            if #available(iOS 15, *) {
                $0.sectionHeaderTopPadding = Design.tableViewSectionHeaderTopPadding
            }
        }
    }
    
    private func configureDataSource() {
        viewModel = ProjectViewModel(tableView: tableViews)
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
}

extension ProjectListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Design.tableViewHeightForHeaderInSection
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withClass: ProjectListTableHeaderView.self)
        switch tableView {
        case todoTableView:
            headerView.populateData(title: TitleText.todoTableViewTitle, count: viewModel?.todoProjects.count ?? 0)
        case doingTableView:
            headerView.populateData(title: TitleText.doingTableViewTitle, count: viewModel?.doingProjects.count ?? 0)
        case doneTableView:
            headerView.populateData(title: TitleText.doneTableViewTitle, count: viewModel?.doneProjects.count ?? 0)
        default:
            break
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { _, _, _ in
            print("DeleteAction")
        }
        
        deleteAction.image = UIImage(systemName: "trash")
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didSelectRow(index: indexPath, tableView: tableView)
    }
    
    func configureBind() {
        viewModel?.onCellSelected = { [weak self] index, project in
            guard let self = self else {
                return
            }
            let editViewController = EditProjectDetailViewController(viewModel: self.viewModel, currentIndex: index, currentProject: project)
            let destinationViewController = UINavigationController(rootViewController: editViewController)
            destinationViewController.modalPresentationStyle = .formSheet
            self.present(destinationViewController, animated: true, completion: nil)
        }
    }
}

//MARK: - Constants

private extension ProjectListViewController {
    enum TitleText {
        static let navigationBarTitle = "Project Manager"
        static let todoTableViewTitle = "TODO"
        static let doingTableViewTitle = "DOING"
        static let doneTableViewTitle = "DONE"
    }

    enum Design {
        static let entireStackViewSpacing: CGFloat = 8
        static let tableViewSectionHeaderTopPadding: CGFloat = 1
        static let tableViewHeightForHeaderInSection: CGFloat = 50
    }
}
