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
    
    private let coredataManager = CoreDataManager()
    
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
    }
}
// MARK: - Business Method
extension MainViewController {
    private func configureLayout() {
        self.view.addSubview(stackView)
        let safeArea = self.view.safeAreaLayoutGuide
        
        [todoTableView, doingTableView, doneTableView].forEach {
            $0.delegate = self
            $0.dataSource = self
            stackView.addArrangedSubview($0)
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
        let result = coredataManager.fetch()
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
        
        data.forEach {
            switch State(rawValue: $0.state) {
            case .todo:
                todoData.append($0)
            case .doing:
                doingData.append($0)
            case .done:
                doneData.append($0)
            case .none:
                return
            }
        }
    }
    
    @objc func tapAddButton() {
        let modalController = UINavigationController(rootViewController: ModalViewContoller())
        modalController.modalPresentationStyle = .formSheet
        
        registDismissNotification()
        self.present(modalController, animated: true, completion: nil)
    }
    
    func registDismissNotification() {
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
        
        self.todoTableView.reloadData()
        self.doneTableView.reloadData()
        self.doingTableView.reloadData()
    }
}


// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: "CustomHeaderView"
        ) as? CustomHeaderView else {
            return UIView()
        }
        
        guard let table = tableView as? CustomTableView else { return UIView() }
        view.titleLabel.text = table.title
        
        if tableView == self.todoTableView {
            view.countLabel.text = todoData.count.description
        } else if tableView == self.doingTableView {
            view.countLabel.text = doingData.count.description
        } else if tableView == self.doneTableView {
            view.countLabel.text = doneData.count.description
        }
        
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
            // 데이터 삭제
            if tableView == self.todoTableView {
                let removeData = self.todoData.remove(at: indexPath.row)
                guard let id = removeData.id else { return }
                self.coredataManager.deleteDate(id: id)
//                self.todoTableView.reloadData()
            } else if tableView == self.doingTableView {
                let removeData = self.doingData.remove(at: indexPath.row)
                guard let id = removeData.id else { return }
                self.coredataManager.deleteDate(id: id)
//                self.doingTableView.reloadData()
            } else if tableView == self.doneTableView {
                let removeData = self.doneData.remove(at: indexPath.row)
                guard let id = removeData.id else { return }
                self.coredataManager.deleteDate(id: id)
//                self.doneTableView.reloadData()
            }
            tableView.reloadData()
        }
        
        return UISwipeActionsConfiguration(actions: [actions])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var data: TodoModel?
        switch tableView {
        case todoTableView:
            data = todoData[indexPath.row]
        case doingTableView:
            data = doingData[indexPath.row]
        case doneTableView:
            data = doneData[indexPath.row]
        default:
            data = nil
        }
        
        let modalController = UINavigationController(rootViewController: ModalViewContoller(model: data))
        modalController.modalPresentationStyle = .formSheet
        self.present(modalController, animated: true, completion: nil)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == todoTableView {
            return todoData.count
        } else if tableView == doingTableView {
            return doingData.count
        } else if tableView == doneTableView {
            return doneData.count
        }
        
        return .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "TodoCustomCell",
            for: indexPath
        ) as? TodoCustomCell else {
            return UITableViewCell()
        }
        
        var data = TodoModel()
        
        if tableView == todoTableView {
            data = todoData[indexPath.row]
        } else if tableView == doingTableView {
            data = doingData[indexPath.row]
        } else if tableView == doneTableView {
            data = doneData[indexPath.row]
        }
        
        guard let todoDate = data.todoDate else { return cell }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        cell.titleLabel.text = data.title
        cell.bodyLabel.text = data.body
        cell.dateLabel.text = dateFormatter.string(from: todoDate)
        
        if todoDate < Date() {
            cell.dateLabel.textColor = .red
        }
        
        return cell
    }
}

//MARK: - GesutreRecognizer, PopoverPresentationController Delegate
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
        
        [todoLongPressedGesture, doingLongPressedGesture, doneLongPressedGesture].forEach {
            $0.delegate = self
            $0.minimumPressDuration = 1
            $0.delaysTouchesBegan = true
        }
        
        todoTableView.addGestureRecognizer(todoLongPressedGesture)
        doingTableView.addGestureRecognizer(doingLongPressedGesture)
        doneTableView.addGestureRecognizer(doneLongPressedGesture)
    }
    
    @objc private func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        guard let tableView = gestureRecognizer.view as? CustomTableView else {
            return
        }
        
        let location = gestureRecognizer.location(in: tableView)
        guard let indexPath = tableView.indexPathForRow(at: location) else { return }
        let indexPathRow = indexPath.row
        
        var data = TodoModel()
        if tableView == todoTableView {
            data = todoData[indexPathRow]
        } else if tableView == doingTableView {
            data = doingData[indexPathRow]
        } else if tableView == doneTableView {
            data = doneData[indexPathRow]
        }
        
        if gestureRecognizer.state == .began {
            guard let id = data.id else { return }
            guard let state = State(rawValue: data.state) else { return }
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
