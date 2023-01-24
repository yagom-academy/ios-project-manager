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
    
    private var todoData = [TodoModel]()
    private var doingData = [TodoModel]()
    private var doneData = [TodoModel]()
    
    private let stackView = UIStackView(
        axis: .horizontal,
        alignment: .fill,
        distribution: .fillEqually
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        configureLayout()
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
        
        [todoTableView, doingTableView, doneTableView].forEach { tableView in
            tableView.delegate = self
            tableView.dataSource = self
            stackView.addArrangedSubview(tableView)
        }
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
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
        todoData = .init()
        doingData = .init()
        doneData = .init()
        
        data.forEach { data in
            switch State(rawValue: data.state) {
            case .todo:
                todoData.append(data)
            case .doing:
                doingData.append(data)
            case .done:
                doneData.append(data)
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

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let dequeuedTableViewHeaderFooterView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: "CustomHeaderView"
        )
        guard let view = dequeuedTableViewHeaderFooterView as? CustomHeaderView,
              let table = tableView as? CustomTableView else {
            return UIView()
        }
        
        view.titleLabel.text = table.title
        view.countLabel.text = countCell(of: tableView).description
        
        return view
    }
    
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let actions = UIContextualAction(
            style: .destructive,
            title: "Delete"
        ) { _, _, _ in
            self.swipeAction(of: tableView, to: indexPath.row)
            tableView.reloadData()
        }
        
        return UISwipeActionsConfiguration(actions: [actions])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = saveData(of: tableView, to: indexPath.row)
        let modalController = UINavigationController(rootViewController: ModalViewContoller(model: data))
        
        modalController.modalPresentationStyle = .formSheet
        self.present(modalController, animated: true, completion: nil)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countCell(of: tableView)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequeuedReusableCell = tableView.dequeueReusableCell(
            withIdentifier: "TodoCustomCell",
            for: indexPath
        )
        guard let cell = dequeuedReusableCell as? TodoCustomCell else { return UITableViewCell() }
        
        let data = saveData(of: tableView, to: indexPath.row)
        
        guard let todoDate = data?.todoDate else { return cell }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        cell.titleLabel.text = data?.title
        cell.bodyLabel.text = data?.body
        cell.dateLabel.text = dateFormatter.string(from: todoDate)
        
        if todoDate < Date() {
            cell.dateLabel.textColor = .red
        }
        
        return cell
    }
}
// MARK: - TableView Business Logic
extension MainViewController {
    func saveData(of tableView: UITableView, to indexPathRow: Int) -> TodoModel? {
        switch tableView {
        case todoTableView:
            return todoData[indexPathRow]
        case doingTableView:
            return doingData[indexPathRow]
        case doneTableView:
            return doneData[indexPathRow]
        default:
            return nil
        }
    }
    
    private func countCell(of tableView: UITableView) -> Int {
        if tableView == self.todoTableView {
            return todoData.count
        } else if tableView == self.doingTableView {
            return doingData.count
        } else if tableView == self.doneTableView {
            return doneData.count
        }
        
        return .zero
    }
    
    private func swipeAction(of tableView: UITableView, to indexPathRow: Int) {
        if tableView == self.todoTableView {
            let removeData = self.todoData.remove(at: indexPathRow)
            guard let id = removeData.id else { return }
            CoreDataManager.shared.deleteDate(id: id)
        } else if tableView == self.doingTableView {
            let removeData = self.doingData.remove(at: indexPathRow)
            guard let id = removeData.id else { return }
            CoreDataManager.shared.deleteDate(id: id)
        } else if tableView == self.doneTableView {
            let removeData = self.doneData.remove(at: indexPathRow)
            guard let id = removeData.id else { return }
            CoreDataManager.shared.deleteDate(id: id)
        }
    }
}

// MARK: - GesutreRecognizer, PopoverPresentationController Delegate
extension MainViewController: UIGestureRecognizerDelegate, UIPopoverPresentationControllerDelegate {
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
         doneLongPressedGesture].forEach { longPressedGesture in
            longPressedGesture.delegate = self
            longPressedGesture.minimumPressDuration = 1
            longPressedGesture.delaysTouchesBegan = true
        }
        
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
            containerController.popoverPresentationController?.sourceRect = CGRect(
                origin: location,
                size: .zero
            )
            containerController.popoverPresentationController?.sourceView = tableView
            containerController.popoverPresentationController?.permittedArrowDirections = [.up, .down]
            
            self.present(containerController, animated: true)
        }
    }
}
