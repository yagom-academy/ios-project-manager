//
//  SectionDivided.swift
//  ProjectManager
//
//  Created by 고은 on 2022/03/10.
//

import UIKit

protocol SectionDivided where Self: NSObject {

    var tableView: UITableView { get }
    var section: TodoSection { get }
    var todoList: [Todo] { get }
}
