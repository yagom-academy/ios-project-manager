//
//  ThingTableView.swift
//  ProjectManager
//
//  Created by 임성민 on 2021/03/12.
//

import UIKit

final class ThingTableView: UITableView, Draggable, Droppable {
    var tableViewType: TableViewType
    
    init<T: UIViewController>(tableViewType: TableViewType, mainViewController: T) where T: UITableViewDataSource & UITableViewDelegate & UITableViewDragDelegate & UITableViewDropDelegate {
        self.tableViewType = tableViewType
        super.init(frame: .zero, style: .grouped)
        tableHeaderView = ThingTableHeaderView(height: 50, tableViewType: tableViewType)
        dataSource = mainViewController
        delegate = mainViewController
        dragDelegate = mainViewController
        dropDelegate = mainViewController
        register(cellType: ThingTableViewCell.self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCount(_ count: Int) {
        if let tableHeaderView = self.tableHeaderView as? ThingTableHeaderView {
            tableHeaderView.setCount(count)
        }
    }
}
