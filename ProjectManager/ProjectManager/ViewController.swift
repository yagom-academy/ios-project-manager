//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var todoTableView: UITableView!
    @IBOutlet weak var doingTableView: UITableView!
    @IBOutlet weak var doneTableView: UITableView!
    
    private let cellNibName = UINib(nibName: TableViewCell.identifier, bundle: nil)
    private let headerNibName = UINib(nibName: HeaderView.identifier, bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoTableView.delegate = self
        todoTableView.dataSource = self
        
        doingTableView.delegate = self
        doingTableView.dataSource = self
        
        doneTableView.delegate = self
        doneTableView.dataSource = self
        
        self.todoTableView.register(cellNibName, forCellReuseIdentifier: TableViewCell.identifier)
        self.todoTableView.register(headerNibName, forHeaderFooterViewReuseIdentifier: HeaderView.identifier)
        
        self.doingTableView.register(cellNibName, forCellReuseIdentifier: TableViewCell.identifier)
        self.doingTableView.register(headerNibName, forHeaderFooterViewReuseIdentifier: HeaderView.identifier)
        
        self.doneTableView.register(cellNibName, forCellReuseIdentifier: TableViewCell.identifier)
        self.doneTableView.register(headerNibName, forHeaderFooterViewReuseIdentifier: HeaderView.identifier)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = self.todoTableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.identifier) as? HeaderView
        else { return UITableViewHeaderFooterView() }
        
        if tableView == todoTableView {
            headerView.headerLabel.text = "TODO"
        }
        if tableView == doingTableView {
            headerView.headerLabel.text = "DOING"
        }
        if tableView == doneTableView {
            headerView.headerLabel.text = "DONE"
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier,
                                                       for: indexPath) as? TableViewCell
        else { return UITableViewCell() }
        
        cell.titleLabel.text = "안녕"
        cell.bodyLabel.text = "나는 본문이야"
        cell.dueDateLabel.text = "2021. 07. 20"
        
        return cell
    }
    
}
