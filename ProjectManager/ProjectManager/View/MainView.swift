//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class MainView: UIViewController {
    
    typealias DataSource = UITableViewDiffableDataSource<Int, Project>
    typealias SnapShot = NSDiffableDataSourceSnapshot<Int, Project>
    
    let toDoListView = ListView(title: "TODO")
    let doingListView = ListView(title: "DOING")
    let doneListView = ListView(title: "DONE")
    let listStack = UIStackView(distribution: .fillEqually,
                                spacing: 5,
                                backgroundColor: .systemGray4)
    
    var toDoDatasource: DataSource?
    var doingDatasource: DataSource?
    var doneDatasource: DataSource?
    var toDoSnapShot: SnapShot = SnapShot()
    var doingSnapShot: SnapShot = SnapShot()
    var doneSnapShot: SnapShot = SnapShot()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpNavigationBar()
        configureDataSource()
        takeSnapShotForToDoList(of: TestModel.todos)
        takeSnapShotForDoingList(of: TestModel.todos)
        takeSnapShotForDoneList(of: TestModel.todos)
        configureLists()
        configureHierarchy()
        configureLayout()
        
        setupCountLabel(of: toDoListView)
        setupCountLabel(of: doingListView)
        setupCountLabel(of: doneListView)
    }
    
    func configureDataSource() {
        toDoDatasource = generateDataSource(for: toDoListView.tableView)
        doingDatasource = generateDataSource(for: doingListView.tableView)
        doneDatasource = generateDataSource(for: doneListView.tableView)
    }
    
    func generateDataSource(for list: UITableView) -> DataSource {
        return DataSource(tableView: list) { tableView, _, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier)
                as? ListCell
            
            cell?.titleLabel.text = item.title
            cell?.descriptionLabel.text = item.description
            cell?.dateLabel.text = item.date.description
            
            return cell
        }
    }
    
    func takeSnapShotForToDoList(of data: [Project]) {
        toDoSnapShot.appendSections(Array(0..<data.count))
        Array(0..<data.count).forEach { index in
            toDoSnapShot.appendItems([data[index]], toSection: index)
        }
        toDoDatasource?.apply(self.toDoSnapShot)
    }
    
    func takeSnapShotForDoingList(of data: [Project]) {
        doingSnapShot.appendSections(Array(0..<data.count))
        Array(0..<data.count).forEach { index in
            doingSnapShot.appendItems([data[index]], toSection: index)
        }
        doingDatasource?.apply(self.doingSnapShot)
    }
    
    func takeSnapShotForDoneList(of data: [Project]) {
        doneSnapShot.appendSections(Array(0..<data.count))
        Array(0..<data.count).forEach { index in
            doneSnapShot.appendItems([data[index]], toSection: index)
        }
        doneDatasource?.apply(self.doneSnapShot)
    }
    
    func setupCountLabel(of list: ListView) {
        list.countLabel.text = String(list.tableView.numberOfSections)
    }
}

// MARK: NavigationBar
extension MainView {
    
    func setUpNavigationBar() {
        let barButtonAction = UIAction { _ in
            // 구현예정
            print("바 버튼 액션동작 확인")
        }
        let barButton = UIBarButtonItem(image: UIImage(systemName: "plus.circle"),
                                        primaryAction: barButtonAction)
        
        self.navigationController?.navigationBar.topItem?.title = "Project Manager"
        self.navigationController?.navigationBar.topItem?.setRightBarButton(barButton,
                                                                            animated: true)
    }
}

// MARK: Layout
extension MainView {
    
    func configureHierarchy() {
        [toDoListView, doingListView, doneListView].forEach {
            listStack.addArrangedSubview($0)
        }
        
        view.addSubview(listStack)
    }
    
    func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            listStack.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            listStack.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            listStack.topAnchor.constraint(equalTo: safeArea.topAnchor),
            listStack.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}

// MARK: UITableViewDelegate
extension MainView: UITableViewDelegate {
    
    func configureLists() {
        [toDoListView, doingListView, doneListView].forEach { listView in
            listView.tableView.delegate = self
            listView.tableView.backgroundColor = .secondarySystemBackground
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = false
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return  UIView()
    }
}
