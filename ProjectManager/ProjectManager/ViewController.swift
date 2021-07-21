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
    @IBOutlet weak var todoCountLabel: UILabel!
    @IBOutlet weak var doingCountLabel: UILabel!
    @IBOutlet weak var doneCountLabel: UILabel!
    
    private let cellNibName = UINib(nibName: TableViewCell.identifier, bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView(todoTableView)
        setTableView(doingTableView)
        setTableView(doneTableView)
        
        setLabelToCircle()
    }
    
    private func setTableView(_ tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellNibName, forCellReuseIdentifier: TableViewCell.identifier)
    }
    
    private func setLabelToCircle() {
        todoCountLabel.layer.masksToBounds = true
        doingCountLabel.layer.masksToBounds = true
        doneCountLabel.layer.masksToBounds = true
        
        todoCountLabel.layer.cornerRadius = 0.5 * todoCountLabel.bounds.size.width
        doingCountLabel.layer.cornerRadius = 0.5 * doingCountLabel.bounds.size.width
        doneCountLabel.layer.cornerRadius = 0.5 * doneCountLabel.bounds.size.width
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 7))

        headerView.backgroundColor = .systemGray6
        
        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 7
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell
        else { return UITableViewCell() }
        
        cell.titleLabel.text = "안녕"
        cell.bodyLabel.text = "나는 본문이야"
        cell.dueDateLabel.text = "2021. 07. 20"
        
        return cell
    }
}
