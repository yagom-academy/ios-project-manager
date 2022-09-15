//
//  ViewModel.swift
//  ProjectManager
//
//  Created by 수꿍, 휴 on 2022/09/15.
//

final class ViewModel {
    var toDoData: Observable<[ProjectUnit]> = Observable([])
    var doingData: Observable<[ProjectUnit]> = Observable([])
    var doneData: Observable<[ProjectUnit]> = Observable([])

    let databaseManager: DatabaseLogic

    init(databaseManager: DatabaseLogic) {
        self.databaseManager = databaseManager
    }
}
