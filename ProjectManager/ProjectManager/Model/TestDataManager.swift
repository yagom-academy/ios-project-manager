//
//  DataList.swift
//  ProjectManager
//
//  Created by 서녕 on 2022/03/02.
//

import Foundation

class TestDataManager {
    lazy var dataList: [ToDoInfomation] = self.fetch()
    
    func save(taskInfomation: ToDoInfomation) {
        dataList.append(taskInfomation)
    }
    
    func delete(at deletTarget: ToDoInfomation) {
        let deleteTargetIndex = dataList.firstIndex { todoInfomation in
            deletTarget.uuid == todoInfomation.uuid
        }
        guard let deleteTargetIndex = deleteTargetIndex else {
            return
        }
        self.dataList.remove(at: deleteTargetIndex)
    }
    
    func fetch() -> [ToDoInfomation] {
        let sortedData = dataList.sorted { $0.deadline > $1.deadline }
        return sortedData
    }
}
