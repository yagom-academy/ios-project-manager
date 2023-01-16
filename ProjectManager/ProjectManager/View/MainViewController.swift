//
//  baem.swift
//  ProjectManager
//
//  Created by Baem on 2023/01/12.
//

import UIKit

class MainViewController: UIViewController {
    let coreDataManager = CoreDataManager()
    
    let todoTableView = CustomTableView(title: "TODO")
    let doingTableView = CustomTableView(title: "DOING")
    let doneTableView = CustomTableView(title: "DONE")
    
    var todoData = [TodoModel]()
    var doingData = [TodoModel]()
    var doneData = [TodoModel]()
    
    let stackView: UIStackView = {
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
    }
    
    func fetchData() {
        let result = coreDataManager.fetch()
        
        switch result {
        case .success(let data):
            data.forEach {
                if $0.state == 0 {
                    todoData.append($0)
                } else if $0.state == 1 {
                    doingData.append($0)
                } else if $0.state == 2 {
                    doneData.append($0)
                }
            }
        case .failure(let error):
            print(error)
        }
    }
    
    func autoLayoutSetting() {
        self.view.addSubview(stackView)
        [todoTableView, doingTableView, doneTableView].forEach(stackView.addArrangedSubview(_:))
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupNavigationBar() {
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
            // TODO: -데이터 삭제
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
        // TODO: -Cell확인
        switch tableView {
        case todoTableView:
            return todoData.count
        case doingTableView:
            return doingData.count
        case doneTableView:
            return doneData.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "TodoCustomCell",
            for: indexPath
        ) as? TodoCustomCell else {
            return UITableViewCell()
        }
        
        switch tableView {
        case todoTableView:
            cell.titleLabel.text = todoData[indexPath.row].title
            cell.bodyLabel.text = todoData[indexPath.row].body
            cell.dateLabel.text = todoData[indexPath.row].todoDate?.description
        case doingTableView:
            cell.titleLabel.text = doingData[indexPath.row].title
            cell.bodyLabel.text = doingData[indexPath.row].body
            cell.dateLabel.text = doingData[indexPath.row].todoDate?.description
        case doneTableView:
            cell.titleLabel.text = doneData[indexPath.row].title
            cell.bodyLabel.text = doneData[indexPath.row].body
            cell.dateLabel.text = doneData[indexPath.row].todoDate?.description
        default:
            return cell
        }
        
        return cell
    }
}
