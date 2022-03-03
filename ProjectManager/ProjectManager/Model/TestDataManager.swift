//
//  DataList.swift
//  ProjectManager
//
//  Created by 서녕 on 2022/03/02.
//

import Foundation

class TestDataManager {
    lazy var dataList: [TaskInfomation] = self.fetch()
    
    func save(taskInfomation: TaskInfomation) {
        dataList.append(taskInfomation)
    }
    
    func delete(at deletTarget: TaskInfomation) {
        let deleteTargetIndex = dataList.firstIndex { taskInfomation in
            deletTarget.uuid == taskInfomation.uuid
        }
        guard let deleteTargetIndex = deleteTargetIndex else {
            return
        }
        self.dataList.remove(at: deleteTargetIndex)
    }
    
    func fetch() -> [TaskInfomation] {
        let sortedData = dataList.sorted { $0.deadline > $1.deadline }
        return sortedData
    }
}
