//
//  TableViewDataSource+Ext.swift
//  ProjectManager
//
//  Created by kio on 2021/07/01.
//

import UIKit

extension ProjectManagerViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectManagerTableViewCell") as? TodoListCell else {
            return UITableViewCell()
        }

        newTodoFormViewController.delegate = cell
        
        cell.selectionStyle = .none
        cell.separatorInset = .zero
        
//        newTodoFormViewController.delegate = cell
//        cell.titleLabel.text = "금연하기 + \(indexPath)"
//        cell.descriptionLabel.text = "담배냄새는 소개팅에서 마이너스, 담배냄새는 소개팅에서 마이너스, 담배냄새는 소개팅에서 마이너스,담배냄새는 소개팅에서 마이너스, 담배냄새는 소개팅에서 마이너스, 담배냄새는 소개팅에서 마이너스, 담배냄새는 소개팅에서 마이너스"
//        cell.dateLabel.text = "2021.07.06"
        
        return cell
    }
}
