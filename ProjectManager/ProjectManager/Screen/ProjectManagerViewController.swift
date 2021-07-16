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
        CellData(title: "바비의 데이트신청", body: "돼지바 먹으며 기다리기", deadline: 1610150400, superViewType: .doingTableView),
        CellData(title: "키오의 이모티콘 만들기2", body: "역시 공부보다 재미있어", deadline: 1610150400, superViewType: .doingTableView)
    ]
    var doneTableViewData : [CellData] = [
        CellData(title: "수지의 탈주하기3", body: "어느 부캠이 좋을까", deadline: 1610150400, superViewType: .doneTableView),
        CellData(title: "바비의 헌팅", body: "모델처럼 서있기", deadline: 1610150400, superViewType: .doneTableView),
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

    override func viewDidLoad() {
        super.viewDidLoad()

        setTableViewControl(tableView: todoTableView)
        setTableViewControl(tableView: doingTableView)
        setTableViewControl(tableView: doneTableView)
        
        setDragAndDrop(tableView: todoTableView)
        setDragAndDrop(tableView: doingTableView)
        setDragAndDrop(tableView: doneTableView)
        
        view.backgroundColor = .systemGray4
        title = "소개팅 필승 공략"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pushNewTodoFormViewController))
        
        configureUndoManagerToolbar()
        configureProjectManagerView()
        configureTitleView()
        configureProcessListsTableView()
        configureListContentsStackview()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        todoTableView.reloadData()
    }
    
    @objc func pushNewTodoFormViewController() {
        let modalViewController = NewTodoFormViewController()
        modalViewController.delegate = self
        
        let newTodoFormNavigationController = UINavigationController(rootViewController: modalViewController)
        
        newTodoFormNavigationController.modalPresentationStyle = .formSheet
        
        modalViewController.isEditMode = false
        modalViewController.enableEdit()
        
        present(newTodoFormNavigationController, animated: true)
    }
    
    private func setTableViewControl(tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setDragAndDrop(tableView: UITableView) {
        tableView.dragInteractionEnabled = true
        tableView.dragDelegate = self
        tableView.dropDelegate = self
    }

    // MARK: - Configure View
    private func configureTitleView() {
        toDoStackView.addArrangedSubview(todoTitleView)
        doingStackView.addArrangedSubview(doingTitleView)
        doneStackView.addArrangedSubview(doneTitleView)
        
        todoTitleView.titleLabel.text = "TODO"
        todoTitleView.countLabel.text = "\(todoTableViewData.count)"
        doingTitleView.titleLabel.text = "DOING"
        doingTitleView.countLabel.text = "\(todoTableViewData.count)"
        doneTitleView.titleLabel.text = "DONE"
        doneTitleView.countLabel.text = "\(todoTableViewData.count)"
        
        todoTitleView.titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        doingTitleView.titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        doneTitleView.titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        
        todoTitleView.countLabel.textColor = .systemBackground
        doingTitleView.countLabel.textColor = .systemBackground
        doneTitleView.countLabel.textColor = .systemBackground
        
        todoTitleView.countLabel.backgroundColor = .black
        doingTitleView.countLabel.backgroundColor = .black
        doneTitleView.countLabel.backgroundColor = .black
        
        todoTitleView.countLabel.textAlignment = .center
        doingTitleView.countLabel.textAlignment = .center
        doneTitleView.countLabel.textAlignment = .center
        
        todoTitleView.countLabel.layer.cornerRadius = 12.5
        todoTitleView.countLabel.layer.masksToBounds = true
        doingTitleView.countLabel.layer.cornerRadius = 12.5
        doingTitleView.countLabel.layer.masksToBounds = true
        doneTitleView.countLabel.layer.cornerRadius = 12.5
        doneTitleView.countLabel.layer.masksToBounds = true
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
    
    func reloadSelectedTableView(tableView: UITableView) {
        tableView.reloadData()
    }
    
    func reloadCountLabel() {
        todoTitleView.countLabel.text = String(todoTableViewData.count)
        doingTitleView.countLabel.text = String(doingTableViewData.count)
        doneTitleView.countLabel.text = String(doneTableViewData.count)
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
        
        guard let sourceIndexPath = item.sourceTableViewIndexPath else {
            return
        }
        
        removeElement(tableView: sourceTableView, indexPath: sourceIndexPath)
        sourceTableView.deleteRows(at: [sourceIndexPath], with: .right)
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
    
    func passPresentingViewData(modalViewController: NewTodoFormViewController, indexPath: IndexPath, data: [CellData]) {
        modalViewController.newTodoFormTextField.text = data[indexPath.row].title
        modalViewController.newTodoFormTextView.text = data[indexPath.row].body
        modalViewController.datePicker.date = Date(timeIntervalSince1970: data[indexPath.row].deadline)
    }
}
