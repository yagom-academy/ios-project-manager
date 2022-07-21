//
//  DetailViewModel.swift
//  ProjectManager
//
//  Created by 김동욱 on 2022/07/12.
//

import Foundation

import RxCocoa
import RxSwift

final class DetailViewModel {
    private var database: DatabaseManagerProtocol
    
    init(database: DatabaseManagerProtocol) {
        self.database = database
    }
    
    func doneButtonTapEvent(
        todo: Todo?,
        selectedTodo: Todo? = nil,
        completion: @escaping () -> Void
    ) {
        guard let todo = todo else {
            return
        }
        
        if selectedTodo != nil {
            self.database.update(selectedTodo: todo)
            completion()
        } else {
            self.database.create(todoData: todo)
            completion()
        }
    }
}
