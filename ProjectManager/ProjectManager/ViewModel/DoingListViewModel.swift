//
//  DoingListViewModel.swift
//  ProjectManager
//
//  Created by 리지 on 2023/05/19.
//

import Foundation
import Combine

final class DoingListViewModel {
    @Published var doingItems: [TodoItem] = []
    
    var numberOfItems: Int {
        return doingItems.count
    }
    
    func item(at index: Int) -> TodoItem {
        return doingItems[index]
    }
}
