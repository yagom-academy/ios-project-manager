//
//  CellViewModel.swift
//  ProjectManager
//
//  Created by Kyo on 2023/01/15.
//

import Foundation

final class CellViewModel {
    private var data: Todo {
        didSet {
            dataHandler?(data)
        }
    }
    
    private var dataHandler: ((Todo?) -> Void)?
    
    init(data: Todo) {
        self.data = data
    }
    
    func bindDate(handler: @escaping (Todo?) -> Void) {
        handler(data)
        self.dataHandler = handler
    }
    
    func checkOverDeadLine() -> Bool {
        if data.isOverDeadLine {
            return true
        }
        return false
    }
}
