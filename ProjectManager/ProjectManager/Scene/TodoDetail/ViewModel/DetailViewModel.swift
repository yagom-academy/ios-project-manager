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
    private var dataBase: DataBase
    
    init(dataBase: DataBase) {
        self.dataBase = dataBase
    }
    
    func doneButtonTapEvent(
        todo: Todo?,
        selectedData: Todo? = nil,
        completion: @escaping () -> Void
    ) {
        guard let todo = todo else {
            return
        }
        
        if let _ = selectedData {
            self.dataBase.update(todo: todo)
            completion()
        } else {
            self.dataBase.create(todoListData: [todo])
            completion()
        }
    }
}
