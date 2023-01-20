//
//  ListViewModel.swift
//  ProjectManager
//
//  Created by leewonseok on 2023/01/18.
//

import Foundation

final class ListViewModel {
    let category: Category
    
    var categoryCount: Int? {
        didSet {
            countHandler?(categoryCount ?? .zero)
        }
    }
    
    init(category: Category) {
        self.category = category
    }
    
    private var countHandler: ((Int) -> Void)?
    
    func load() {
        countHandler?(categoryCount ?? .zero)
    }
    
    func bindCount(handler: @escaping (Int) -> Void) {
        countHandler = handler
    }
}
