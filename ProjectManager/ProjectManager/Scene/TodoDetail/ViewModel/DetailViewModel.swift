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
    private var dataBase: Database
    
    init(dataBase: Database) {
        self.dataBase = dataBase
    }
    
    func doneButtonTapEvent(
        todo: Todo?,
        selectedTodo: Todo? = nil,
        completion: @escaping () -> Void
    ) {
        guard let todo = todo else {
            return
        }
        
        if let _ =         selectedTodo {
            self.dataBase.update(selectedTodo: todo)
            completion()
        } else {
            self.dataBase.create(todoList: [todo])
            completion()
        }
    }
}
