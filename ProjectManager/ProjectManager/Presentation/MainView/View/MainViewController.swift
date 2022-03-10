import UIKit

class MainViewController: UIViewController {
    
    private let todoTableView: UITableView = {
        let tableview = UITableView(frame: .zero)
        tableview.register(ProjectUITableViewCell.self, forCellReuseIdentifier: String(describing: ProjectUITableViewCell()))
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    private let doingTableView: UITableView = {
        let tableview = UITableView()
        tableview.register(ProjectUITableViewCell.self, forCellReuseIdentifier: String(describing: ProjectUITableViewCell()))
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    private let doneTableView: UITableView = {
        let tableview = UITableView()
        tableview.register(ProjectUITableViewCell.self, forCellReuseIdentifier: String(describing: ProjectUITableViewCell()))
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
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureLayout()
    }
    
    private func configureNavigationItems() {
        self.navigationItem.title = "ProjectManager"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didtappedRightBarButton))
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


