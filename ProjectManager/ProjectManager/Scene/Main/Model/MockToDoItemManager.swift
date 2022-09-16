//
//  MockToDoItemManager.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/10.
//

import Foundation

final class MockToDoItemManager {
    
    // MARK: - Properties

    private var mockToDoItemContent = [ToDoItem]()
    
    // MARK: - Functions
 
    func loadData() -> ItemListCatory {
        guard let data: ItemListCatory? = JSONDecoder.decodedJson(jsonName: Design.jsonName),
              let mockItem = data else { return ItemListCatory() }
        return mockItem
    }
    
    func count() -> Int {
        return mockToDoItemContent.count
    }
    
    func content(index: Int) -> ToDoItem? {
        return mockToDoItemContent.get(index: index)
    }
    
    private enum Design {
        static let jsonName = "MockData"
    }
}
