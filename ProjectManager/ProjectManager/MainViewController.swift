import UIKit

class MainViewController: UIViewController {
    private let toDoTableView = ProjectListTableView()
    private let doingTableView = ProjectListTableView()
    private let doneTableView = ProjectListTableView()
    private let toDoDataSourceDelegate = ToDoDataSourceDelegate()
    private let doingDataSourceDelegate = DoingDataSourceDelegate()
    private let doneDataSourceDelegate = DoneDataSourceDelegate()
    private let toDoHeader = ProjectListHeaderView(title: "TODO")
    private let doingHeader = ProjectListHeaderView(title: "DOING")
    private let doneHeader = ProjectListHeaderView(title: "DONE")
    
    private let addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        
        return button
    }()
    
    private lazy var toDoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [toDoHeader, toDoTableView])
        stackView.axis = .vertical
        toDoHeader.heightAnchor.constraint(equalToConstant: 55).isActive = true
        stackView.distribution = .fill
        
        return stackView
    }()
    
    private lazy var doingStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [doingHeader, doingTableView])
        stackView.axis = .vertical
        doingHeader.heightAnchor.constraint(equalToConstant: 55).isActive = true
        stackView.distribution = .fill
        
        return stackView
    }()
    
    private lazy var doneStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [doneHeader, doneTableView])
        stackView.axis = .vertical
        doneHeader.heightAnchor.constraint(equalToConstant: 55).isActive = true
        stackView.distribution = .fill
        
        return stackView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [toDoStackView, doingStackView, doneStackView])
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
            toDoStackView.heightAnchor.constraint(equalTo: mainStackView.heightAnchor),
            doingStackView.heightAnchor.constraint(equalTo: mainStackView.heightAnchor),
            doneStackView.heightAnchor.constraint(equalTo: mainStackView.heightAnchor)
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
