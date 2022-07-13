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

    func doneButtonTapEvent(todo: Todo?, completion: @escaping () -> Void) {
        guard let todo = todo else {
            return
        }

        self.dataBase.save(todoListData: [todo])
        completion()
    }
}
