//
//  ProjectManager - MainViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class MainViewController: UIViewController {
    
    // MARK: Properties
    
    private let projectManagerView = MainProjectManagerView()
    private let section: [String] = ["TODO", "DOING", "DONE"]
    private var todoList: [CellInfo] = []
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = projectManagerView
        
        configureView()
        projectManagerView.setUpTableView(with: self)
    }
    
    // MARK: Private Methods
    
    private func configureView() {
        view.backgroundColor = .systemGray2
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(plusButtonAction)
        )
    }
    
    // MARK: Action Methods
    
    @objc
    private func plusButtonAction() {
        let popUpViewController = AddViewController()
        popUpViewController.modalPresentationStyle = .overCurrentContext
        popUpViewController.delegate = self
        
        navigationController?.present(popUpViewController, animated: true)
    }
}

// MARK: - TableViewDelegate

extension MainViewController: UITableViewDelegate {
}

// MARK: - TableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch tableView {
        case projectManagerView.leftTableView:
            return "TODO"
        case projectManagerView.centerTableView:
            return "DOING"
        case projectManagerView.rightTableView:
            return "DONE"
        default:
            return String()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case projectManagerView.leftTableView:
            return 10
        case projectManagerView.centerTableView:
            return todoList.count
        case projectManagerView.rightTableView:
            return 5
        default:
            return .zero
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case projectManagerView.leftTableView:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: MainLeftTableViewCell.identifier,
                for: indexPath
            )
            return cell
        case projectManagerView.centerTableView:
            if let cell = tableView.dequeueReusableCell(
                withIdentifier: MainCenterTableViewCell.identifier,
                for: indexPath
            ) as? MainCenterTableViewCell {
                let projectTodoList = todoList[indexPath.row]
                
                cell.configureLabel(todoList: projectTodoList)
                
                return cell
            }
            
            return UITableViewCell()
        case projectManagerView.rightTableView:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: MainRightTableViewCell.identifier,
                for: indexPath
            )
            return cell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - DataSendDelegate

extension MainViewController: DataSendDelegate {
    func sendData(project: CellInfo) {
        todoList.append(project)
        projectManagerView.reloadTableView()
    }
}
