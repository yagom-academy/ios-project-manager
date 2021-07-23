//
//  ViewController+DataSource.swift
//  ProjectManager
//
//  Created by 이영우 on 2021/07/22.
//

import UIKit

//extension ViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        switch tableView {
//        case todoTableView:
//            return todoTasks.count
//        case doingTableView:
//            return doingTasks.count
//        case doneTableView:
//            return doneTasks.count
//        default:
//            return 0
//        }
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.identifier) as? ItemTableViewCell else {
//            return UITableViewCell()
//        }
//
//        switch tableView {
//        case todoTableView:
//            cell.configure(task: todoTasks[indexPath.row])
//        case doingTableView:
//            cell.configure(task: doingTasks[indexPath.row])
//        case doneTableView:
//            cell.configure(task: doneTasks[indexPath.row])
//        default:
//            print("error")
//        }
//        return cell
//    }
//}
