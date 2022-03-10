import UIKit

class MainViewController: UIViewController {
    private let toDoTableView = UITableView()
    private let doingTableView = UITableView()
    private let doneTableView = UITableView()
    
    private let toDoDataSource = ToDoDataSource()
    private let doingDataSource = DoingDataSource()
    private let doneDataSource = DoneDataSource()
    
    private let toDoHeader = ProjectListHeaderView(title: "TODO")
    private let doingHeader = ProjectListHeaderView(title: "DOING")
    private let doneHeader = ProjectListHeaderView(title: "DONE")
    
    private lazy var toDoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [toDoHeader, toDoTableView])
        stackView.axis = .vertical
        toDoHeader.heightAnchor.constraint(equalToConstant: 55).isActive = true
        stackView.distribution = .fill
        toDoTableView.backgroundColor = .secondarySystemBackground
        
        return stackView
    }()
    
    private lazy var doingStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [doingHeader, doingTableView])
        stackView.axis = .vertical
        doingHeader.heightAnchor.constraint(equalToConstant: 55).isActive = true
        stackView.distribution = .fill
        doingTableView.backgroundColor = .secondarySystemBackground
        
        return stackView
    }()
    
    private lazy var doneStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [doneHeader, doneTableView])
        stackView.axis = .vertical
        doneHeader.heightAnchor.constraint(equalToConstant: 55).isActive = true
        stackView.distribution = .fill
        doneTableView.backgroundColor = .secondarySystemBackground
        
        return stackView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [toDoStackView, doingStackView, doneStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .systemGray3
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBar()
        setupStackViewLayout()
        registerProjectListCell()
        addLongPressGesture()
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
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddProjectView))
        navigationItem.title = "Project Manager"
        navigationItem.rightBarButtonItem = addButton
    }
    
    private func setupTableView() {
        toDoTableView.delegate = self
        doingTableView.delegate = self
        doneTableView.delegate = self
        toDoTableView.dataSource = toDoDataSource
        doingTableView.dataSource = doingDataSource
        doneTableView.dataSource = doneDataSource
    }
    
    private func registerProjectListCell() {
        toDoTableView.register(ProjectListCell.self)
        doingTableView.register(ProjectListCell.self)
        doneTableView.register(ProjectListCell.self)
    }
    
    @objc private func showAddProjectView() {
        let viewController = AddProjectViewController()
        viewController.modalPresentationStyle = .formSheet
        present(viewController, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = EditProjectViewController()
        viewController.modalPresentationStyle = .formSheet
        present(viewController, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, _  in
            print("Delete project")
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

// MARK: - LongPressGesture

extension MainViewController {
    private func addLongPressGesture() {
        let todoLongPressGestrue = UILongPressGestureRecognizer(target: self, action: #selector(presentToDoLongPressMenu(_:)))
        let doingLongPressGestrue = UILongPressGestureRecognizer(target: self, action: #selector(presentDoingLongPressMenu(_:)))
        let doneLongPressGestrue = UILongPressGestureRecognizer(target: self, action: #selector(presentDoneLongPressMenu(_:)))
        toDoTableView.addGestureRecognizer(todoLongPressGestrue)
        doingTableView.addGestureRecognizer(doingLongPressGestrue)
        doneTableView.addGestureRecognizer(doneLongPressGestrue)
    }
    
    private func makePopoverAlert(with sectionTitles: [String]) -> UIAlertController {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let moveToFirstSectionAction = UIAlertAction(title: sectionTitles[0], style: .default)
        let moveToSecondSectionAction = UIAlertAction(title: sectionTitles[1], style: .default)
        alert.addAction(moveToFirstSectionAction)
        alert.addAction(moveToSecondSectionAction)
        
        return alert
    }

    @objc private func presentToDoLongPressMenu(_ longPresss: UILongPressGestureRecognizer) {
        let sectionTitles = ["Move To DOING", "Move To DONE"]
        let locationInView = longPresss.location(in: toDoTableView)
        guard let indexPath = toDoTableView.indexPathForRow(at: locationInView) else { return }

        if longPresss.state == .began {
            let alert = makePopoverAlert(with: sectionTitles)
            alert.popoverPresentationController?.sourceView = toDoTableView.cellForRow(at: indexPath)
            present(alert, animated: true)
        }
    }

    @objc private func presentDoingLongPressMenu(_ longPresss: UILongPressGestureRecognizer) {
        let sectionTitles = ["Move To TODO", "Move To DONE"]
        let locationInView = longPresss.location(in: doingTableView)
        guard let indexPath = doingTableView.indexPathForRow(at: locationInView) else { return }

        if longPresss.state == .began {
            let alert = makePopoverAlert(with: sectionTitles)
            alert.popoverPresentationController?.sourceView = doingTableView.cellForRow(at: indexPath)
            present(alert, animated: true)
        }
    }

    @objc private func presentDoneLongPressMenu(_ longPresss: UILongPressGestureRecognizer) {
        let sectionTitles = ["Move To TODO", "Move To DOING"]
        let locationInView = longPresss.location(in: doneTableView)
        guard let indexPath = doneTableView.indexPathForRow(at: locationInView) else { return }

        if longPresss.state == .began {
            let alert = makePopoverAlert(with: sectionTitles)
            alert.popoverPresentationController?.sourceView = doneTableView.cellForRow(at: indexPath)
            present(alert, animated: true)
        }
    }
}
