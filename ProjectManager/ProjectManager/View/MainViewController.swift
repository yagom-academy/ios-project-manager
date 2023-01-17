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
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        [todoTableView, doingTableView, doneTableView].forEach {
            $0.delegate = self
            $0.dataSource = self
        }
        
        autoLayoutSetting()
        setupNavigationBar()
        fetchData()
        todoTableView.reloadData()
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
            switch $0.state {
            case 0:
                todoData.append($0)
            case 1:
                doingData.append($0)
            case 2:
                doneData.append($0)
            default:
                return
            }
        }
    }
    
    private func autoLayoutSetting() {
        self.view.addSubview(stackView)
        [todoTableView, doingTableView, doneTableView].forEach(stackView.addArrangedSubview(_:))
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
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
    
    @objc func tapAddButton() {
        let modalController = UINavigationController(rootViewController: ModalViewContoller(mode: .create))
        modalController.modalPresentationStyle = .formSheet
        
        self.present(modalController, animated: true, completion: nil)
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
                self.todoTableView.reloadData()
            } else if tableView == self.doingTableView {
                let removeData = self.doingData.remove(at: indexPath.row)
                guard let id = removeData.id else { return }
                self.coredataManager.deleteDate(id: id)
                self.doingTableView.reloadData()
            } else if tableView == self.doneTableView {
                let removeData = self.doneData.remove(at: indexPath.row)
                guard let id = removeData.id else { return }
                self.coredataManager.deleteDate(id: id)
                self.doneTableView.reloadData()
            }
        }
        
        return UISwipeActionsConfiguration(actions: [actions])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
            data = todoData[indexPath.row]
        } else if tableView == doneTableView {
            data = todoData[indexPath.row]
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
