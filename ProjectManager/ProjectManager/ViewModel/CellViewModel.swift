//
//  CellViewModel.swift
//  ProjectManager
//
//  Created by Kyo on 2023/01/15.
//

import Foundation

final class CellViewModel {
    private var data: Plan = Plan(title: "") {
        didSet {
            dataHandler?(data)
        }
    }
    
    private var dataHandler: ((Plan) -> Void)?
}

// MARK: - Method
extension CellViewModel {
    func bindData(handler: @escaping (Plan) -> Void) {
        self.dataHandler = handler
    }
    
    func setupData(_ data: Plan) {
        self.data = data
    }
    
    func checkOverDeadLine() -> Bool {
        return data.isOverDeadLine
    }
}
