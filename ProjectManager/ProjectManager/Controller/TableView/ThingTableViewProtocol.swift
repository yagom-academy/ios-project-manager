//
//  ThingTableViewProtocol.swift
//  ProjectManager
//
//  Created by 임성민 on 2021/03/17.
//

import UIKit

protocol ThingTableViewProtocol: UITableView {
    var list: [Thing] { get }
    
    func createThing(_ thing: Thing)
    func updateThing(_ thing: Thing, index: Int)
    func deleteThing(at indexPath: IndexPath)
    func insertThing(_ thing: Thing, at indexPath: IndexPath)
    func setCount(_ count: Int)
}
