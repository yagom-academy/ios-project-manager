import UIKit

final class MainViewController: UIViewController {
    
    private let viewModel: TodoListViewModel
    
    private let todoTableView: UITableView = {
        let tableview = UITableView(frame: .zero)
        tableview.register(
            ProjectUITableViewCell.self,
            forCellReuseIdentifier: String(describing: ProjectUITableViewCell())
        )
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    private let doingTableView: UITableView = {
        let tableview = UITableView()
        tableview.register(
            ProjectUITableViewCell.self,
            forCellReuseIdentifier: String(describing: ProjectUITableViewCell())
        )
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    private let doneTableView: UITableView = {
        let tableview = UITableView()
        tableview.register(
            ProjectUITableViewCell.self,
            forCellReuseIdentifier: String(describing: ProjectUITableViewCell())
        )
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                self.todoTableView,
                self.doingTableView,
                self.doneTableView
            ]
        )
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 10.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    // MARK: - initializer
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(viewModel: TodoListViewModel) {
        self.init(viewModel: viewModel)
    }
    // MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureLayout()
    }
    // MARK: - method 
    private func configureNavigationItems() {
        self.navigationItem.title = "ProjectManager"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didtappedRightBarButton)
        )
    }
    
    @objc func didtappedRightBarButton() {
        
    }
    
    private func configureTableView() {
        view.addSubview(stackView)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}


