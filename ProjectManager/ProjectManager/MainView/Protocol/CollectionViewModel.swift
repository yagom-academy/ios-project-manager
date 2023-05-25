//
//  CollectionViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/24.
//

import UIKit

protocol CollectionViewModel: AnyObject {
    associatedtype DataSource
    associatedtype Item
    
    var items: [Item] { get set }
    
    func makeDataSource() throws -> DataSource
    
    func task(at: IndexPath) -> Item?

    func updateTask(id: UUID)
    
    func remove(_ item: Item)
}
