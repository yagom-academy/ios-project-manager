//
//  ProjectManager - MainViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class MainViewController: UIViewController {
    
    typealias DataSource = UITableViewDiffableDataSource<Section, Project>
    typealias SnapShot = NSDiffableDataSourceSnapshot<Section, Project>
    
    var viewModel = MainViewModel()
    let lists: [ListView] = [ListView(), ListView(), ListView()]
    var dataSources: [DataSource?] = Array(repeating: nil, count: Process.allCases.count)
    var snapShots: [SnapShot] = Array(repeating: SnapShot(), count: Process.allCases.count)
    let listStack = UIStackView(distribution: .fillEqually,
                                spacing: 5,
                                backgroundColor: .systemGray4)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpNavigationBar()
        configureDataSource()
        takeSnapShotForToDoList(of: TestModel.todos)
        takeSnapShotForDoingList(of: TestModel.doings)
        takeSnapShotForDoneList(of: TestModel.todos)
        viewModel.setUpInitialData()
        configureLists()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpListHead()
        configureHierarchy()
        configureLayout()
    }
        
    func configureDataSource() {
        lists.enumerated().forEach { index, listView in
            dataSources[index] = generateDataSource(for: listView.tableView)
        }
    }
    
    func generateDataSource(for list: UITableView) -> DataSource {
        return DataSource(tableView: list) { tableView, _, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier)
                as? ListCell
            
            cell?.setupViews(viewModel: ListCellViewModel(project: item))

            return cell
        }
    }
    
    func takeSnapShotForToDoList(of data: [Project]) {
        let todoIndex = Process.todo.index
        
        snapShots[todoIndex].appendSections([.main])
        snapShots[todoIndex].appendItems(data, toSection: .main)
        dataSources[todoIndex]?.apply(self.snapShots[todoIndex])
    }
    
    func takeSnapShotForDoingList(of data: [Project]) {
        let doingIndex = Process.doing.index
        
        snapShots[doingIndex].appendSections([.main])
        snapShots[doingIndex].appendItems(data, toSection: .main)
        dataSources[doingIndex]?.apply(self.snapShots[doingIndex])
    }
    
    func takeSnapShotForDoneList(of data: [Project]) {
        let doneIndex = Process.done.index

        snapShots[doneIndex].appendSections([.main])
        snapShots[doneIndex].appendItems(data, toSection: .main)
        dataSources[doneIndex]?.apply(self.snapShots[doneIndex])
    }
    
    func setUpListHead() {
        lists.enumerated().forEach { index, listView in
            listView.titleLabel.text = viewModel.processTitles[index]
            setupCountLabel(of: listView)
        }
    }
    
    func setupCountLabel(of list: ListView) {
        list.countLabel.text = String(list.tableView.numberOfRows(inSection: 0))
    }
}

// MARK: NavigationBar
extension MainViewController {
    
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
extension MainViewController {
    
    func configureHierarchy() {
        lists.forEach {
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
extension MainViewController: UITableViewDelegate {
    
    func configureLists() {
        lists.forEach {
            $0.tableView.delegate = self
            $0.tableView.backgroundColor = .secondarySystemBackground
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = false
        
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.opacity = 0.3
        tableView.cellForRow(at: indexPath)?.selectedBackgroundView = view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return  UIView()
    }
}

enum Section {
    case main
}
