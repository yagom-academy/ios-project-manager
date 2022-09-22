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
 
    func loadData() -> ItemListCategory {
        guard let data: ItemListCategory? = JSONDecoder.decodedJson(jsonName: Design.jsonName),
              let mockItem = data else { return ItemListCategory() }
        return mockItem
    }
    
    private enum Design {
        static let jsonName = "MockData"
    }
}
