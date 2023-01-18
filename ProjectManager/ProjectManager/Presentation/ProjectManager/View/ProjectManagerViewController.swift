//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import RxSwift
import RxCocoa

final class ProjectManagerViewController: UIViewController {
    
    var todoTableView: UITableView = {
        let table = UITableView()
        table.register(TaskCell.self, forCellReuseIdentifier: "task")
        return table
    }()
    var doingTableView: UITableView = {
        let table = UITableView()
        table.register(TaskCell.self, forCellReuseIdentifier: "task")
        return table
    }()
    var doneTableView: UITableView = {
        let table = UITableView()
        table.register(TaskCell.self, forCellReuseIdentifier: "task")
        return table
    }()
    
    let viewModel = ProjectManagerViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationController()
        configureView()
        bindViewModel()
    }
    
    func bindViewModel() {
        viewModel.subject
            .share()
            .map { $0.filter { $0.tag == .todo } }
            .bind(to: todoTableView.rx.items) { tableview, row, item in
                guard let cell = tableview.dequeueReusableCell(withIdentifier: "task") as? TaskCell
                else {
                    return TaskCell()
                }
                cell.setUp(with: item)
                return cell
            }
            .disposed(by: disposeBag)
        
        viewModel.subject
            .share()
            .map { $0.filter { $0.tag == .doing } }
            .bind(to: doingTableView.rx.items) { tableview, row, item in
                guard let cell = tableview.dequeueReusableCell(withIdentifier: "task") as? TaskCell
                else {
                    return TaskCell()
                }
                cell.setUp(with: item)
                return cell
            }
            .disposed(by: disposeBag)
        
        viewModel.subject
            .share()
            .map { $0.filter { $0.tag == .done } }
            .bind(to: doneTableView.rx.items) { tableview, row, item in
                guard item.tag == .done else { return }
                guard let cell = tableview.dequeueReusableCell(withIdentifier: "task") as? TaskCell
                else {
                    return TaskCell()
                }
                cell.setUp(with: item)
                return cell
            }
            .disposed(by: disposeBag)
    }
    
    private func configureNavigationController() {
        if let navigationController = self.navigationController {
            let navigationBar = navigationController.navigationBar
            navigationBar.backgroundColor = UIColor.systemGray
            let rightAddButton = UIBarButtonItem(barButtonSystemItem: .add, target: self,
                                                 action: #selector(tapNavigationAddButton))
            navigationController.title = "Project Manager"
            navigationItem.rightBarButtonItem = rightAddButton
        }
    }
    
    private func configureView() {
        self.view.backgroundColor = UIColor.systemGray3
    }
    
    @objc
    private func tapNavigationAddButton() {
        // TODO: Add some action
    }
}

