//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
//

import UIKit

class ProjectManagerViewController: UIViewController {
    
    var todoTableViewData: [CellData] = [
        CellData(title: "수지의 탈주하기", body: "어느 부캠이 좋을까", deadline: 1610150400, superViewType: .todoTableView),
        CellData(title: "바비의 다이어트", body: "쿠팡에서 다이어트 음식 시켜야지", deadline: 1610150400, superViewType: .todoTableView),
        CellData(title: "키오의 이모티콘 만들기", body: "역시 공부보다 재미있어", deadline: 1610150400, superViewType: .todoTableView)
    ]
    var doingTableViewData : [CellData] = [
        CellData(title: "수지의 탈주하기2", body: "어느 부캠이 좋을까", deadline: 1610150400, superViewType: .doingTableView),
        CellData(title: "바비의 다이어트2", body: "쿠팡에서 다이어트 음식 시켜야지", deadline: 1610150400, superViewType: .doingTableView),
        CellData(title: "키오의 이모티콘 만들기2", body: "역시 공부보다 재미있어", deadline: 1610150400, superViewType: .doingTableView)
    ]
    var doneTableViewData : [CellData] = [
        CellData(title: "수지의 탈주하기3", body: "어느 부캠이 좋을까", deadline: 1610150400, superViewType: .doneTableView),
        CellData(title: "바비의 다이어트3", body: "쿠팡에서 다이어트 음식 시켜야지", deadline: 1610150400, superViewType: .doneTableView),
        CellData(title: "키오의 이모티콘 만들기3", body: "역시 공부보다 재미있어", deadline: 1610150400, superViewType: .doneTableView)
    ]
    
    let processListsStackView = ProcessListsStackView()
    let toDoStackView = ListContentsStackview()
    let doingStackView = ListContentsStackview()
    let doneStackView = ListContentsStackview()
    let undoManagerToolbar = UndoManagerToolbar()
    
    let todoTitleView = ListTitleView()
    let doingTitleView = ListTitleView()
    let doneTitleView = ListTitleView()
    
    let todoTableView = UITableView()
    let doingTableView = UITableView()
    let doneTableView = UITableView()
    
    let newTodoFormViewController = NewTodoFormViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addDragAndDropInteraction()
        
        view.backgroundColor = .systemGray4
        title = "소개팅 필승 공략"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pushNewTodoFormViewController))
        newTodoFormViewController.delegate = self
        configureUndoManagerToolbar()
        configureProjectManagerView()
        configureTitleView()
        configureProcessListsTableView()
        configureListContentsStackview()
        
        todoTableView.dataSource = self
        doingTableView.dataSource = self
        doneTableView.dataSource = self
        
        todoTableView.delegate = self
        doingTableView.delegate = self
        doneTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        todoTableView.reloadData()
        print("viewWillAppear")
        print(todoTableViewData)
    }
    
    private func addDragAndDropInteraction() {
        todoTableView.dragInteractionEnabled = true
        doingTableView.dragInteractionEnabled = true
        doneTableView.dragInteractionEnabled = true
        
        todoTableView.dragDelegate = self
        doingTableView.dragDelegate = self
        doneTableView.dragDelegate = self
        
        todoTableView.dropDelegate = self
        doingTableView.dropDelegate = self
        doneTableView.dropDelegate = self
    }
    
    @objc func pushNewTodoFormViewController() {
        let newTodoFormNavigationController = NewTodoFormNavigationController(rootViewController: newTodoFormViewController)
        newTodoFormNavigationController.modalPresentationStyle = .formSheet
        
        newTodoFormViewController.mode = "New"
        newTodoFormViewController.newTodoFormTextField.isUserInteractionEnabled = true
        newTodoFormViewController.newTodoFormTextView.isUserInteractionEnabled = true
        newTodoFormViewController.datePicker.isUserInteractionEnabled = true
        
        present(newTodoFormNavigationController, animated: true)
    }

    // MARK: - Configure View
    private func configureTitleView() {
        toDoStackView.addArrangedSubview(todoTitleView)
        doingStackView.addArrangedSubview(doingTitleView)
        doneStackView.addArrangedSubview(doneTitleView)
        
        todoTitleView.title.text = "TODO"
        todoTitleView.count.text = "\(todoTableViewData.count)"
        doingTitleView.title.text = "DOING"
        doingTitleView.count.text = "\(todoTableViewData.count)"
        doneTitleView.title.text = "DONE"
        doneTitleView.count.text = "\(todoTableViewData.count)"
        
        todoTitleView.title.font = UIFont.boldSystemFont(ofSize: 30)
        doingTitleView.title.font = UIFont.boldSystemFont(ofSize: 30)
        doneTitleView.title.font = UIFont.boldSystemFont(ofSize: 30)
        
        todoTitleView.count.textColor = .systemBackground
        doingTitleView.count.textColor = .systemBackground
        doneTitleView.count.textColor = .systemBackground
        
        todoTitleView.count.backgroundColor = .black
        doingTitleView.count.backgroundColor = .black
        doneTitleView.count.backgroundColor = .black
        
        todoTitleView.count.textAlignment = .center
        doingTitleView.count.textAlignment = .center
        doneTitleView.count.textAlignment = .center
        
        todoTitleView.count.layer.cornerRadius = 12.5
        todoTitleView.count.layer.masksToBounds = true
        doingTitleView.count.layer.cornerRadius = 12.5
        doingTitleView.count.layer.masksToBounds = true
        doneTitleView.count.layer.cornerRadius = 12.5
        doneTitleView.count.layer.masksToBounds = true
    }
    
    private func configureProcessListsTableView() {
        toDoStackView.addArrangedSubview(todoTableView)
        doingStackView.addArrangedSubview(doingTableView)
        doneStackView.addArrangedSubview(doneTableView)
        
        todoTableView.showsVerticalScrollIndicator = false
        doingTableView.showsVerticalScrollIndicator = false
        doneTableView.showsVerticalScrollIndicator = false
        
        todoTableView.tableFooterView = UIView(frame: .zero)
        doingTableView.tableFooterView = UIView(frame: .zero)
        doneTableView.tableFooterView = UIView(frame: .zero)
        
        todoTableView.backgroundColor = .systemGray6
        doingTableView.backgroundColor = .systemGray6
        doneTableView.backgroundColor = .systemGray6
        
        todoTableView.register(TodoListCell.self, forCellReuseIdentifier: TodoListCell.identifier)
        doingTableView.register(TodoListCell.self, forCellReuseIdentifier: TodoListCell.identifier)
        doneTableView.register(TodoListCell.self, forCellReuseIdentifier: TodoListCell.identifier)
    }
    
    private func configureListContentsStackview() {
        processListsStackView.addArrangedSubview(toDoStackView)
        processListsStackView.addArrangedSubview(doingStackView)
        processListsStackView.addArrangedSubview(doneStackView)
    }
    
    private func configureProjectManagerView() {
        view.addSubview(processListsStackView)
        
        NSLayoutConstraint.activate([
            processListsStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            processListsStackView.bottomAnchor.constraint(equalTo: undoManagerToolbar.safeAreaLayoutGuide.topAnchor),
            processListsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            processListsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func configureUndoManagerToolbar() {
        view.addSubview(undoManagerToolbar)
        undoManagerToolbar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            undoManagerToolbar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            undoManagerToolbar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            undoManagerToolbar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    // MARK: - functional Methods
    func removeElement(tableView: UITableView, indexPath: IndexPath) {
        switch tableView {
        case todoTableView:
            todoTableViewData.remove(at: indexPath.row)
        case doingTableView:
            doingTableViewData.remove(at: indexPath.row)
        default:
            doneTableViewData.remove(at: indexPath.row)
        }
    }
    
    func reloadCountLabel() {
        todoTitleView.count.text = String(todoTableViewData.count)
        doingTitleView.count.text = String(doingTableViewData.count)
        doneTitleView.count.text = String(doneTableViewData.count)
    }
    
    func distinguishedTableViewData(currentTableView: UITableView) -> [CellData] {
        switch currentTableView {
        case todoTableView:
            return self.todoTableViewData
        case doingTableView:
            return self.doingTableViewData
        default:
            return self.doneTableViewData
        }
    }
    
    func distinguishedTableView(currentTableView: UITableView) -> TableViewType {
        switch currentTableView {
        case todoTableView:
            return .todoTableView
        case doingTableView:
            return .doingTableView
        default:
            return .doneTableView
        }
    }
    
    func dragItems(for indexPath: IndexPath, tableView: UITableView) -> [UIDragItem] {
        let sourceTableViewData = distinguishedTableViewData(currentTableView: tableView)
        let cellData = sourceTableViewData[indexPath.row]
        cellData.sourceTableViewIndexPath = indexPath
        let itemProvider = NSItemProvider(object: cellData)
        
        return [UIDragItem(itemProvider: itemProvider)]
    }
    
    func moveItem(at sourceIndex: Int, to destinationIndex: Int, tableView: UITableView) {
        guard sourceIndex != destinationIndex else { return }

        var tableViewData = distinguishedTableViewData(currentTableView: tableView)
        
        let place = tableViewData[sourceIndex]
        tableViewData.remove(at: sourceIndex)
        tableViewData.insert(place, at: destinationIndex)
    }
    
    func addItem(currentTableView: UITableView, _ place: CellData, at index: Int) {
        switch currentTableView {
        case todoTableView:
            todoTableViewData.insert(place, at: index)
        case doingTableView:
            doingTableViewData.insert(place, at: index)
        default:
            doneTableViewData.insert(place, at: index)
        }
    }
    
    func reorderTableView(item: CellData, indexPath: IndexPath, destinationTableView: TableViewType) {
        switch item.superViewType {
        case .todoTableView:
            updateData(item: item, indexPath: indexPath, sourceTableView: todoTableView, currentTableView: destinationTableView)
        case .doingTableView:
            updateData(item: item, indexPath: indexPath, sourceTableView: doingTableView, currentTableView: destinationTableView)
        case .doneTableView:
            updateData(item: item, indexPath: indexPath, sourceTableView: doneTableView, currentTableView: destinationTableView)
        }
    }
    
    func updateData(item: CellData, indexPath: IndexPath, sourceTableView: UITableView, currentTableView: TableViewType) {
        
        removeElement(tableView: sourceTableView, indexPath: item.sourceTableViewIndexPath!)
        sourceTableView.deleteRows(at: [item.sourceTableViewIndexPath!], with: .right)
        reloadCountLabel()
        item.superViewType = currentTableView
        item.sourceTableViewIndexPath = indexPath
    }
    
    func formattedDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: date)
        
        return date
    }
    
    func configureCell(cell: TodoListCell, tableView: UITableView, indexPath: IndexPath) {
        let data = distinguishedTableViewData(currentTableView: tableView)
        
        let currentDate = Date()
        let deadlineDate = Date(timeIntervalSince1970: data[indexPath.row].deadline)
        
        let convertDate = formattedDate(date: deadlineDate)
        
        if currentDate > deadlineDate {
            cell.dateLabel.textColor = .systemRed
        } else {
            cell.dateLabel.textColor = .black
        }
        
        cell.selectionStyle = .none
        cell.separatorInset = .zero
        cell.titleLabel.text = data[indexPath.row].title
        cell.dateLabel.text = "\(convertDate)"
        cell.descriptionLabel.text = data[indexPath.row].body
    }
}
