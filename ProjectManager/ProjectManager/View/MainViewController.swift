//
//  baem.swift
//  ProjectManager
//
//  Created by Baem on 2023/01/12.
//

import UIKit

final class MainViewController: UIViewController {
    private let todoTableView = CustomTableView(title: "TODO")
    private let doingTableView = CustomTableView(title: "DOING")
    private let doneTableView = CustomTableView(title: "DONE")
    
    private let mainTableViewDataSource = MainTableViewDataSource()
    private let mainTableViewDelegate = MainTableViewDelegate()
    
    private let stackView = UIStackView(
        axis: .horizontal,
        alignment: .fill,
        distribution: .fillEqually
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        configureLayout()
        configureTableView()
        setupNavigationBar()
        fetchData()
        setupLongPress()
        registDismissNotification()
    }
}

// MARK: - Business Method
extension MainViewController {
    private func configureLayout() {
        self.view.addSubview(stackView)
        let safeArea = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        
    }
    
    private func configureTableView() {
        mainTableViewDelegate.someDelegate = self
        
        [todoTableView, doingTableView, doneTableView].forEach { tableView in
            tableView.delegate = mainTableViewDelegate
            tableView.dataSource = mainTableViewDataSource
            stackView.addArrangedSubview(tableView)
        }
    }
    
    private func setupNavigationBar() {
        let rightBarbutton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(tapAddButton)
        )
        
        navigationItem.title = "Project Manager"
        navigationItem.rightBarButtonItem = rightBarbutton
    }
    
    private func fetchData() {
        let result = CoreDataManager.shared.fetchData()
        switch result {
        case .success(let data):
            distributeData(data: data)
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
    private func distributeData(data: [TodoModel]) {
        todoTableView.data = .init()
        doingTableView.data = .init()
        doneTableView.data = .init()
        
        data.forEach { data in
            switch State(rawValue: data.state) {
            case .todo:
                todoTableView.data.append(data)
            case .doing:
                doingTableView.data.append(data)
            case .done:
                doneTableView.data.append(data)
            case .none:
                return
            }
        }
    }
    
    @objc func tapAddButton() {
        let modalController = UINavigationController(rootViewController: ModalViewContoller())
        modalController.modalPresentationStyle = .formSheet
        
        self.present(modalController, animated: true, completion: nil)
    }
    
    private func registDismissNotification() {
        let notification = Notification.Name("DismissForReload")
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(dismissModal),
            name: notification,
            object: nil
        )
    }
    
    @objc private func dismissModal() {
        fetchData()
        [self.todoTableView, self.doneTableView, self.doingTableView].forEach { tableView in
            tableView.reloadData()
        }
    }
}

// MARK: - TableView Business Logic
extension MainViewController {
    private func saveData(of tableView: UITableView, to indexPathRow: Int) -> TodoModel? {
        guard let tableView = tableView as? CustomTableView else { return nil }
        return tableView.data[indexPathRow]
    }
    
    private func countCell(of tableView: UITableView) -> Int {
        guard let tableView = tableView as? CustomTableView else { return .zero }
        return tableView.data.count
    }
    
    private func swipeAction(of tableView: UITableView, to indexPathRow: Int) {
        guard let tableView = tableView as? CustomTableView else { return }
        
        let removeData = tableView.data.remove(at: indexPathRow)
        guard let id = removeData.id else { return }
        CoreDataManager.shared.deleteDate(id: id)
    }
}

// MARK: - GesutreRecognizer, PopoverPresentationController
extension MainViewController {
    private func setupLongPress() {
        let todoLongPressedGesture = UILongPressGestureRecognizer(
            target: self,
            action: #selector(handleLongPress(gestureRecognizer:))
        )
        let doingLongPressedGesture = UILongPressGestureRecognizer(
            target: self,
            action: #selector(handleLongPress(gestureRecognizer:))
        )
        let doneLongPressedGesture = UILongPressGestureRecognizer(
            target: self,
            action: #selector(handleLongPress(gestureRecognizer:))
        )
        
        [todoLongPressedGesture,
         doingLongPressedGesture,
         doneLongPressedGesture].forEach { longPressedGesture in longPressedGesture.minimumPressDuration = 1 }
        
        todoTableView.addGestureRecognizer(todoLongPressedGesture)
        doingTableView.addGestureRecognizer(doingLongPressedGesture)
        doneTableView.addGestureRecognizer(doneLongPressedGesture)
    }
    
    @objc private func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        guard let tableView = gestureRecognizer.view as? CustomTableView else { return }
        
        let location = gestureRecognizer.location(in: tableView)
        guard let indexPath = tableView.indexPathForRow(at: location) else { return }
        guard let data = saveData(of: tableView, to: indexPath.row) else { return }
        
        if gestureRecognizer.state == .began {
            guard let id = data.id,
                  let state = State(rawValue: data.state) else { return }
            let containerController = PopoverViewController(id: id, state: state)
            containerController.modalPresentationStyle = .popover
            containerController.configureView(CGRect(origin: location, size: .zero), tableView)
            
            self.present(containerController, animated: true)
        }
    }
}

// MARK: - DataSenable
extension MainViewController: DataSendable {
    func sendData(model: TodoModel) {
        let modalController = UINavigationController(rootViewController: ModalViewContoller(model: model))
        
        modalController.modalPresentationStyle = .formSheet
        present(modalController, animated: true, completion: nil)
    }
}
