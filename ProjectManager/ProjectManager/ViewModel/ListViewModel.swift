//
//  ListViewModel.swift
//  ProjectManager
//
//  Created by leewonseok on 2023/01/12.
//

import Foundation

class ListViewModel {
    var workList: [Work] = [] {
        didSet {
            workListHandler?(workList)
        }
    }
    
    private var workListHandler: (([Work]) -> Void)?
    
    func workTodoList(handler: @escaping ([Work]) -> Void) {
        workListHandler = handler
    }
}
