//
//  CellViewModel.swift
//  ProjectManager
//
//  Created by Kyo on 2023/01/15.
//

import Foundation

final class CellViewModel {
    private var data: Plan {
        didSet {
            dataHandler?(data)
        }
    }
    
    private var dataHandler: ((Plan?) -> Void)?
    
    init(data: Plan) {
        self.data = data
    }
}

// MARK: - Method
extension CellViewModel {
    func bindDate(handler: @escaping (Plan?) -> Void) {
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
