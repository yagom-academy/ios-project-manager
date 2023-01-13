//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    typealias DataSource = UITableViewDiffableDataSource<Int, Project>
    typealias SnapShot = NSDiffableDataSourceSnapshot<Int, Project>
    
    let toDoListView = ListView(title: "TODO")
    let listStack = UIStackView(distribution: .fillEqually, spacing: 10)
    var toDoDatasource: DataSource?
    var toDoSnapShot: SnapShot?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureDataSource()
        takeSnapShot()
    }
    
    func configureDataSource() {
        toDoDatasource = DataSource(tableView: toDoListView.tableView) { tableView, _, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: ProjectCell.identifier)
                as? ProjectCell
            
            cell?.titleLabel.text = item.title
            cell?.descriptionLabel.text = item.description
            cell?.dateLabel.text = item.date.description
            
            return cell
        }
    }
    
    func takeSnapShot() {
        toDoSnapShot = SnapShot()
        toDoSnapShot?.appendSections(Array(0..<TestModel.todos.count))
        Array(0..<TestModel.todos.count).forEach { index in
            toDoSnapShot?.appendItems([TestModel.todos[index]], toSection: index)
        }
        self.toDoDatasource?.apply(self.toDoSnapShot ?? SnapShot())
    }
    
    func configureHierarchy() {
        [toDoListView].forEach {
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

class TestModel {
    static let title = "ToDo"
    static let todos = [
        Project(title: "test용 모델 제목 1",
                description: """
                하위 버전 호환성에는 문제가 없는가?
                안정적으로 운용 가능한가?
                미래 지속가능성이 있는가?
                리스크를 최소화 할 수 있는가? 알고있는 리스크는 무엇인가?
                어떤 의존성 관리도구를 사용하여 관리할 수 있는가?
                이 앱의 요구기능에 적절한 선택인가?
                """,
                date: Date()),
        Project(title: "2번", description: "000하기", date: Date()),
        Project(title: "3번", description: "000하기", date: Date()),
        Project(title: "4번", description: "000하기", date: Date()) ]
}
