//
//  ProjectManager - MainHomeViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class MainHomeViewController: UIViewController {

    @IBOutlet weak var doingTableView: UITableView!
    @IBOutlet weak var todoTableView: UITableView!
    @IBOutlet weak var doneTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        todoTableView.dataSource = self
        todoTableView.delegate = self

        doingTableView.dataSource = self
        doingTableView.delegate = self

        doneTableView.dataSource = self
        doneTableView.delegate = self
    }
}

extension MainHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == todoTableView {
            return 5
        } else if tableView == doingTableView {
            return 3
        } else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if tableView == todoTableView {
            let cell = todoTableView.dequeueReusableCell(withIdentifier: "todoTableViewCell", for: indexPath) as! TableViewCell
            cell.titleLabel.text = "Todo 제목"
            cell.descriptionLabel.text = "Todo 설명"
            cell.deadlineLabel.text = "Todo 기한"
            return cell
        } else if tableView == doingTableView {
            let cell = todoTableView.dequeueReusableCell(withIdentifier: "todoTableViewCell", for: indexPath) as! TableViewCell
            cell.titleLabel.text = "Doing 제목"
            cell.descriptionLabel.text = "Doing 설명"
            cell.deadlineLabel.text = "Doing 기한"
            return cell
        } else {
            let cell = todoTableView.dequeueReusableCell(withIdentifier: "todoTableViewCell", for: indexPath) as! TableViewCell
            cell.titleLabel.text = "Done 제목"
            cell.descriptionLabel.text = "Done 설명"
            cell.deadlineLabel.text = "Done 기한"
            return cell
        }
    }
}
