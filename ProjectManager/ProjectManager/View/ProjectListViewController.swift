import UIKit
private enum TitleText {
    static let navigationBarTitle = "Project Manager"
    static let todoTableViewTitle = "TODO"
    static let doingTableViewTitle = "DOING"
    static let doneTableViewTitle = "DONE"
}

private enum Design {
    static let entireStackViewSpacing: CGFloat = 8
    static let tableViewSectionHeaderTopPadding: CGFloat = 1
    static let tableViewHeightForHeaderInSection: CGFloat = 50
}

class ProjectListViewController: UIViewController {
    private let todoTableView = ProjectListTableView()
    private let doingTableView = ProjectListTableView()
    private let doneTableView = ProjectListTableView()
    
    private lazy var entireStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [todoTableView, doingTableView, doneTableView])
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
        let viewController = ProjectDetailViewController()
        let destinationViewController = UINavigationController(rootViewController: viewController)

        destinationViewController.modalPresentationStyle = .formSheet
        present(destinationViewController, animated: true, completion:nil)
    }
    
    private func configureTableView() {
        todoTableView.dataSource = self
        todoTableView.delegate = self
        doingTableView.delegate = self
        doingTableView.dataSource = self
        doneTableView.delegate = self
        doneTableView.dataSource = self
        if #available(iOS 15, *) {
            todoTableView.sectionHeaderTopPadding = Design.tableViewSectionHeaderTopPadding
            doingTableView.sectionHeaderTopPadding = Design.tableViewSectionHeaderTopPadding
            doneTableView.sectionHeaderTopPadding = Design.tableViewSectionHeaderTopPadding
        }
    }
    
    private func configureEntireStackView() {
        self.view.addSubview(entireStackView)
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

extension ProjectListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: ProjectTableViewCell.self)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { _, _, _ in
            print("DeleteAction")
        }
        
        deleteAction.image = UIImage(systemName: "trash")
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
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
            headerView.populateData(title: TitleText.todoTableViewTitle, count: 20)
        case doingTableView:
            headerView.populateData(title: TitleText.doingTableViewTitle, count: 30)
        case doneTableView:
            headerView.populateData(title: TitleText.doneTableViewTitle, count: 40)
        default:
            break
        }
        
        return headerView
    }
}
