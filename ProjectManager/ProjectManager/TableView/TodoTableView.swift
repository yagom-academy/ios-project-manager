//
//  TodoTableVIew.swift
//  ProjectManager
//
//  Created by 임성민 on 2021/03/17.
//

import UIKit

final class TodoTableView: ThingTableView {
    
    //MARK: - Init

    override init() {
        super.init()
        tableHeaderView = ThingTableHeaderView(height: 50, title: Strings.todoTitle)
        NotificationCenter.default.addObserver(self, selector: #selector(setList(_:)), name: NSNotification.Name("broadcasttodo"), object: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        tableHeaderView = ThingTableHeaderView(height: 50, title: Strings.todoTitle)
        NotificationCenter.default.addObserver(self, selector: #selector(setList(_:)), name: NSNotification.Name("broadcasttodo"), object: nil)
    }
    
    @objc func setList(_ notification: NSNotification) {
        if let userInfo = notification.userInfo,
           let list = userInfo[Strings.todoState] as? [Thing] {
            self.list = list
        }
    }
    
    //MARK: - CRUD
    
    func createThing(title: String, description: String, date: Double, lastModified: Double) {
        let thing = Thing(context: CoreDataStack.shared.persistentContainer.viewContext)
        thing.id = 0
        thing.title = title
        thing.detailDescription = description
        thing.dateNumber = date
        thing.lastModified = lastModified
        thing.state = Strings.todoState
        NetworkManager.create(thing: thing) { _ in
            do {
            try CoreDataStack.shared.persistentContainer.viewContext.save()
            } catch {
                debugPrint("core data error")
            }
        }
        list.insert(thing, at: 0)
    }
 
}
