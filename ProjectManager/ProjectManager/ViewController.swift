//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var toDoTableView: UITableView!
    @IBOutlet weak var doingTableView: UITableView!
    @IBOutlet weak var doneTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toDoTableView.dataSource = self
        toDoTableView.dragDelegate = self
        toDoTableView.register(Header.self, forHeaderFooterViewReuseIdentifier: "TODO")
        toDoTableView.delegate = self
        
        doingTableView.dataSource = self
        doingTableView.dragDelegate = self
        doingTableView.register(Header.self, forHeaderFooterViewReuseIdentifier: "DOING")
        doingTableView.delegate = self
        
        doneTableView.dataSource = self
        doneTableView.dragDelegate = self
        doneTableView.register(Header.self, forHeaderFooterViewReuseIdentifier: "DONE")
        doneTableView.delegate = self
    }
}

// MARK: UITableView DataSource

extension ViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch tableView {
        case toDoTableView:
            let toDoCell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath) as? ToDoTableViewCell ?? UITableViewCell()
            return toDoCell
            
        case doingTableView:
            let doingCell = tableView.dequeueReusableCell(withIdentifier: "doingCell", for: indexPath) as? DoingTableViewCell ?? UITableViewCell()
            return doingCell
            
        case doneTableView:
            let doneCell = tableView.dequeueReusableCell(withIdentifier: "doneCell", for: indexPath) as? DoneTableViewCell ?? UITableViewCell()
            return doneCell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch tableView {
        case toDoTableView:
            return customizeHeaderView(in: tableView, withIdentifier: "TODO")
            
        case doingTableView:
            return customizeHeaderView(in: tableView, withIdentifier: "DOING")
            
        case doneTableView:
            return customizeHeaderView(in: tableView, withIdentifier: "DONE")
            
        default:
            return nil
        }
    }
    
    private func customizeHeaderView(in tableView: UITableView, withIdentifier identifier: String) -> Header? {
        let customizedHeader = toDoTableView.dequeueReusableHeaderFooterView(withIdentifier: identifier) as? Header ?? nil
        customizedHeader?.title.text = identifier
        return customizedHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}

// MARK: UITableView DragDelegate

extension ViewController: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return [UIDragItem(itemProvider: NSItemProvider())]
    }
}

// MARK: UITableView DropDelegate

extension ViewController: UITableViewDropDelegate {
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
            if session.localDragSession != nil {
                return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
            }
            return UITableViewDropProposal(operation: .cancel, intent: .unspecified)
        }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        
    }
}


