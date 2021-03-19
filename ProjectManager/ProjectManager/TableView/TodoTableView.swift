//
//  TodoTableVIew.swift
//  ProjectManager
//
//  Created by 임성민 on 2021/03/17.
//

import UIKit

final class TodoTableView: ThingTableView {
    override init() {
        super.init()
        tableHeaderView = ThingTableHeaderView(height: 50, title: Strings.todoTitle)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        tableHeaderView = ThingTableHeaderView(height: 50, title: Strings.todoTitle)
    }
}
