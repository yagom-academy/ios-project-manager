//
//  ProjectManager - ToDoListViewContorller.swift
//  Created by goat.
//  Copyright © goat. All rights reserved.
//

import UIKit

class ToDoListViewContorller: UIViewController, sendToDoListProtocol {
    
    private var toDoList: [ToDoList]?
    private var doingList: [ToDoList]?
    private var doneList: [ToDoList]?
    
    func sendTodoList(data: ToDoList, isCreatMode: Bool) {
        if isCreatMode == true {
            toDoList?.append(data)
        } else {
            if let index = toDoList?.firstIndex(where: { $0.title == data.title}) {
                toDoList?[index] = data
            }
        }
        reloadTableView()
    }
    
    private let toDoStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.distribution = .fillEqually
        return stackview
    }()
    
    lazy var toDoTableView = createTableView(title: "TODO")
    lazy var doingTableView = createTableView(title: "DOING")
    lazy var doneTableView = createTableView(title: "DONE")
    
    private func reloadTableView() {
        toDoTableView.reloadData()
        doingTableView.reloadData()
        doneTableView.reloadData()
    }
    
    private func createTableView(title: String) -> UITableView {
        let tableview = UITableView()
        tableview.backgroundColor = .systemGray6
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60))
        
        let headerLabel = UILabel(frame: headerView.bounds)
        headerLabel.text = title
        headerLabel.font = .systemFont(ofSize: 32,weight: .medium)
        headerLabel.textAlignment = .natural
        headerView.addSubview(headerLabel)
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20)
        ])
        tableview.tableHeaderView = headerView
        
        return tableview
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toDoList = []
        doingList = []
        doneList = []
        
        setUpLongPressGesture()
        configureNavigationBar()
        setUpTableView()
        configureViewUI()
    }
    
    // MARK: LongTouchPress, Popover
    private func setUpLongPressGesture() {
        let tableViews: [UITableView] = [toDoTableView, doingTableView, doneTableView]
        for tableView in tableViews {
            let longTouchGesture = UILongPressGestureRecognizer(target: self, action: #selector(longTouchPressed))
            longTouchGesture.minimumPressDuration = 0.3
            tableView.addGestureRecognizer(longTouchGesture)
        }
    }
    
    @objc private func longTouchPressed(_ recognizer: UILongPressGestureRecognizer) {
        guard let tableView = recognizer.view as? UITableView else { return }
        
        if recognizer.state == .began {
            
            if tableView == toDoTableView {
                showPopover(firstTitle: "MOVE TO DOING",
                            secondTitle: "MOVE TO DONE",
                            firstHandler: { _ in self.moveToDoing() },
                            secondHandler: { _ in self.moveToDone() })
            } else if tableView == doingTableView {
                showPopover(firstTitle: "MOVE TO TODO",
                            secondTitle: "MOVE TO DONE",
                            firstHandler: { _ in self.moveToTodo() },
                            secondHandler: { _ in self.moveToDone() }
                )
            } else if tableView == doneTableView {
                showPopover(firstTitle: "MOVE TO TODO",
                            secondTitle: "MOVE TO DOING",
                            firstHandler: { _ in self.moveToTodo() },
                            secondHandler: { _ in self.moveToDoing() }
                )
            }
        }
    }
    
    private func showPopover(firstTitle: String, secondTitle: String, firstHandler:((UIAlertAction) -> Void)?, secondHandler:((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: "이동", message: "", preferredStyle: .actionSheet)
        
        let firstAction = UIAlertAction(title: "Move To DOING", style: .default, handler: firstHandler)
        let secondeAction = UIAlertAction(title: "Move To DONE", style: .default, handler: secondHandler)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(firstAction)
        alertController.addAction(secondeAction)
        alertController.addAction(cancelAction)
        
        guard let popoverController = alertController.popoverPresentationController else { return }
        popoverController.sourceView = self.view
        popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
        popoverController.permittedArrowDirections = []
        present(alertController, animated: true, completion: nil)
    }
    
    private func moveToDoing() {
  
    }
    
    private func moveToDone() {
        
    }
    
    private func moveToTodo() {
        
    }
    
    // MARK: NavigationBar
    private func configureNavigationBar() {
        navigationItem.title = "Project Manager"
        let plusButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonTapped))
        navigationItem.rightBarButtonItem = plusButton
    }
    
    @objc private func plusButtonTapped() {
        let toDoWriteViewController = ToDoWriteViewController(mode: .create)
        toDoWriteViewController.modalPresentationStyle = .formSheet
        
        toDoWriteViewController.delegate = self
        
        self.present(toDoWriteViewController, animated: true)
    }
    
    // MARK: TableView Setting
    private func setUpTableView() {
        toDoTableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: ToDoTableViewCell.identifier)
        doingTableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: ToDoTableViewCell.identifier)
        doneTableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: ToDoTableViewCell.identifier)
        
        toDoTableView.delegate = self
        toDoTableView.dataSource = self
        
        doingTableView.delegate = self
        doingTableView.dataSource = self
        
        doneTableView.delegate = self
        doneTableView.dataSource = self
    }
    
    // MARK: Autolayout
    private func configureViewUI() {
        view.backgroundColor = .white
        view.addSubview(toDoStackView)
        
        toDoStackView.addArrangedSubview(toDoTableView)
        toDoStackView.addArrangedSubview(doingTableView)
        toDoStackView.addArrangedSubview(doneTableView)
        
        let safeArea = view.safeAreaLayoutGuide
        
        toDoStackView.translatesAutoresizingMaskIntoConstraints = false
        toDoTableView.translatesAutoresizingMaskIntoConstraints = false
        doingTableView.translatesAutoresizingMaskIntoConstraints = false
        doneTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            toDoStackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            toDoStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            toDoStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            toDoStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }
}

extension ToDoListViewContorller: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let toDoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ToDoTableViewCell", for: indexPath) as? ToDoTableViewCell,
              let toDoList = self.toDoList else { return }
        toDoTableViewCell.setUpLabel(toDoList: toDoList[indexPath.row])
        
        let toDoWriteViewController = ToDoWriteViewController(mode: .edit, fetchedTodoList: toDoList[indexPath.row])
        toDoWriteViewController.modalPresentationStyle = .formSheet
        toDoWriteViewController.delegate = self
        
        self.present(toDoWriteViewController, animated: true)
    }
}

extension ToDoListViewContorller: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == toDoTableView {
            return toDoList?.count ?? 0
        } else if tableView == doingTableView {
            return doingList?.count ?? 0
        } else if tableView == doneTableView {
            return doneList?.count ?? 0
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let toDoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ToDoTableViewCell", for: indexPath) as? ToDoTableViewCell,
              let toDoList = self.toDoList,
              let doingList = self.doingList,
              let doneList = self.doneList else { return UITableViewCell() }
        
        if tableView == toDoTableView {
            toDoTableViewCell.setUpLabel(toDoList: toDoList[indexPath.row])
        } else if tableView == doingTableView {
            toDoTableViewCell.setUpLabel(toDoList: doingList[indexPath.row])
        } else if tableView == doneTableView {
            toDoTableViewCell.setUpLabel(toDoList: doneList[indexPath.row])
        }
        return toDoTableViewCell
    }
}
