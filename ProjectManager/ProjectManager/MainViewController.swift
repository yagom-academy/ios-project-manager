import UIKit

class MainViewController: UIViewController {
    private let toDoTableView = ProjectListTableView(title: "TODO")
    private let doingTableView = ProjectListTableView(title: "DOING")
    private let doneTableView = ProjectListTableView(title: "DONE")
    private let toDoDataSourceDelegate = ToDoDataSourceDelegate()
    private let doingDataSourceDelegate = DoingDataSourceDelegate()
    private let doneDataSourceDelegate = DoneDataSourceDelegate()
    
    private let addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)

        return button
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [toDoTableView, doingTableView, doneTableView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBar()
        setupStackViewLayout()
        registerProjectListCell()
    }
    
    private func setupStackViewLayout() {
        view.addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            toDoTableView.heightAnchor.constraint(equalTo: mainStackView.heightAnchor),
            doingTableView.heightAnchor.constraint(equalTo: mainStackView.heightAnchor),
            doneTableView.heightAnchor.constraint(equalTo: mainStackView.heightAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Project Manager"
        navigationItem.rightBarButtonItem = addButton
    }
    
    private func setupTableView() {
        toDoTableView.dataSource = toDoDataSourceDelegate
        toDoTableView.delegate = toDoDataSourceDelegate
        doingTableView.dataSource = doingDataSourceDelegate
        doingTableView.delegate = doingDataSourceDelegate
        doneTableView.dataSource = doneDataSourceDelegate
        doneTableView.delegate = doneDataSourceDelegate
    }
    
    private func registerProjectListCell() {
        toDoTableView.register(ProjectListCell.self)
        doingTableView.register(ProjectListCell.self)
        doneTableView.register(ProjectListCell.self)
    }
}
