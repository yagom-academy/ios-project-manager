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
    private var todoList: [ProjectData] = []
    private var doingList: [ProjectData] = []
    private var doneList: [ProjectData] = []
    
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
            return todoList.count
        case projectManagerView.centerTableView:
            return doingList.count
        case projectManagerView.rightTableView:
            return doneList.count
        default:
            return .zero
        }
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todoList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case projectManagerView.leftTableView:
            if let cell = tableView.dequeueReusableCell(
                withIdentifier: MainLeftTableViewCell.identifier,
                for: indexPath
            ) as? MainLeftTableViewCell {
                let projectTodoList = todoList[indexPath.row]
                
                cell.configureLabel(todoList: projectTodoList)
                
                return cell
            }
            
            return UITableViewCell()
        case projectManagerView.centerTableView:
            if let cell = tableView.dequeueReusableCell(
                withIdentifier: MainCenterTableViewCell.identifier,
                for: indexPath
            ) as? MainCenterTableViewCell {
                let projectDoingList = doingList[indexPath.row]
                
                cell.configureLabel(doingList: projectDoingList)
                
                return cell
            }
            
            return UITableViewCell()
        case projectManagerView.rightTableView:
            if let cell = tableView.dequeueReusableCell(
                withIdentifier: MainRightTableViewCell.identifier,
                for: indexPath
            ) as? MainRightTableViewCell {
                let projectDoneList = doneList[indexPath.row]
                
                cell.configureLabel(doneList: projectDoneList)
                
                return cell
            }
            
            return UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - DataSendDelegate

extension MainViewController: DataSendable {
    func sendData(with projectData: ProjectData) {
        todoList.append(project)
        projectManagerView.reloadTableView()
    }
}
