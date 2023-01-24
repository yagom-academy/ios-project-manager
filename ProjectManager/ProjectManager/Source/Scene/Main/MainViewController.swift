//
//  ProjectManager - MainViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class MainViewController: UIViewController {
    
    // MARK: Private Properties
    
    private let projectManagerView = MainProjectManagerView()
    private let section: [String] = [
        MainNameSpace.todoAllUpper,
        NameSpace.doingAllUpper,
        NameSpace.doneAllUpper
    ]
    private var editedTodoListCount: Int?
    private var todoList: [ProjectData] = []
    private var doingList: [ProjectData] = []
    private var doneList: [ProjectData] = []
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = projectManagerView
        
        configureView()
        setUpTableViewLongPressAction()
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
    
    private func setUpTableViewLongPressAction() {
        let longPressAction = UILongPressGestureRecognizer(target: self, action: #selector(didLongPressTableView))
        
        projectManagerView.leftTableView.addGestureRecognizer(longPressAction)
    }
    
    private func createActionSheet() {
        let actionSheet = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet
        )
        let moveToDoing = UIAlertAction(
            title: NameSpace.moveToDoing,
            style: .default) { [self] _ in
                if let todoListCount = editedTodoListCount {
                    doingList.append(todoList[todoListCount])
                    todoList.remove(at: todoListCount)
                    projectManagerView.reloadTableView()
                }
            }
        let moveToDone = UIAlertAction(
            title: NameSpace.moveToDone,
            style: .default) { [self] _ in
                if let todoListCount = editedTodoListCount {
                    doneList.append(todoList[todoListCount])
                    todoList.remove(at: todoListCount)
                    projectManagerView.reloadTableView()
                }
            }
        
        actionSheet.addAction(moveToDoing)
        actionSheet.addAction(moveToDone)
        
        checkPopOverPresentation(device: .pad, actionSheet: actionSheet)
        
        present(actionSheet, animated: true)
    }
    
    private func checkPopOverPresentation(device: UIUserInterfaceIdiom, actionSheet: UIAlertController) {
        if device == .pad {
            if let presenter = actionSheet.popoverPresentationController {
                presenter.permittedArrowDirections = []
                presenter.sourceView = view
                presenter.sourceRect = CGRect(
                    x: view.bounds.midX,
                    y: view.bounds.maxY,
                    width: 0,
                    height: 0
                )
            }
        }
    }
    
    // MARK: Action Methods
    
    @objc
    private func plusButtonAction() {
        let popUpViewController = AddViewController()
        popUpViewController.delegate = self
        popUpViewController.modalPresentationStyle = .overCurrentContext
        popUpViewController.dataManagementMode = .create
        
        navigationController?.present(popUpViewController, animated: true)
        projectManagerView.reloadTableView()
    }
}

// MARK: - TableViewDelegate

extension MainViewController: UITableViewDelegate {}

// MARK: - TableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch tableView {
        case projectManagerView.leftTableView:
            return MainNameSpace.todoAllUpper + "  " + String(todoList.count)
        case projectManagerView.centerTableView:
            return NameSpace.doingAllUpper + "  " + String(doingList.count)
        case projectManagerView.rightTableView:
            return NameSpace.doneAllUpper + "  " + String(doneList.count)
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
            switch tableView {
            case projectManagerView.leftTableView:
                todoList.remove(at: indexPath.row)
            case projectManagerView.centerTableView:
                doingList.remove(at: indexPath.row)
            case projectManagerView.rightTableView:
                doneList.remove(at: indexPath.row)
            default:
                break
            }
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            projectManagerView.reloadTableView()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case projectManagerView.leftTableView:
            if let cell = tableView.dequeueReusableCell(
                withIdentifier: MainTableViewCell.leftIdentifier,
                for: indexPath
            ) as? MainTableViewCell {
                let projectData = todoList[indexPath.row]
                
                cell.configureLabel(data: projectData)
                cell.selectionStyle = .none
                
                return cell
            }
            
            return UITableViewCell()
        case projectManagerView.centerTableView:
            if let cell = tableView.dequeueReusableCell(
                withIdentifier: MainTableViewCell.centerIdentifier,
                for: indexPath
            ) as? MainTableViewCell {
                let projectData = doingList[indexPath.row]
                
                cell.configureLabel(data: projectData)
                cell.selectionStyle = .none
                
                return cell
            }
            
            return UITableViewCell()
        case projectManagerView.rightTableView:
            if let cell = tableView.dequeueReusableCell(
                withIdentifier: MainTableViewCell.rightIdentifier,
                for: indexPath
            ) as? MainTableViewCell {
                let projectData = doneList[indexPath.row]
                
                cell.configureLabel(data: projectData)
                cell.selectionStyle = .none
                
                return cell
            }
            
            return UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let popUpViewController = AddViewController()
        
        popUpViewController.modalPresentationStyle = .overCurrentContext
        popUpViewController.delegate = self
        popUpViewController.dataManagementMode = .read
        
        switch tableView {
        case projectManagerView.leftTableView:
            popUpViewController.savedData = todoList[indexPath.row]
        case projectManagerView.centerTableView:
            popUpViewController.savedData = doingList[indexPath.row]
        case projectManagerView.rightTableView:
            popUpViewController.savedData = doneList[indexPath.row]
        default:
            break
        }
        
        editedTodoListCount = indexPath.row
        
        navigationController?.present(popUpViewController, animated: true)
    }
}

// MARK: - DataSendDelegate

extension MainViewController: DataSendable {
    func sendData(with data: ProjectData, mode: DataManagementMode) {
        switch mode {
        case .create:
            todoList.append(data)
            projectManagerView.reloadTableView()
        case .edit:
            if let todoListCount = editedTodoListCount {
                todoList[todoListCount] = data
                projectManagerView.reloadTableView()
            }
        case .read:
            break
        }
    }
}

// MARK: - UIGestureRecognizerDelegate

extension MainViewController: UIGestureRecognizerDelegate {
    @objc
    private func didLongPressTableView(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let touchPoint = sender.location(in: projectManagerView.leftTableView)
            if projectManagerView.leftTableView.indexPathForRow(at: touchPoint) != nil {
                let location = sender.location(in: sender.view)
                if let cellRow = projectManagerView.leftTableView.indexPathForRow(at: location) {
                    editedTodoListCount = cellRow.row
                    createActionSheet()
                }
            }
        }
    }
}

// MARK: - NameSpace

private enum NameSpace {
    static let doingAllUpper = "DOING"
    static let doneAllUpper = "DONE"
    
    static let moveToDoing = "Move to DOING"
    static let moveToDone = "Move to DONE"
}
