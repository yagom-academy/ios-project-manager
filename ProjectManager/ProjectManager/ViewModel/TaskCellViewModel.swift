//
//  TaskCellViewModel.swift
//  ProjectManager
//
//  Created by 서녕 on 2022/03/04.
//

import Foundation

class TaskCellViewModel {
    let dataManager = TestDataManager()
    
    func cellData(indexPath: Int) -> TaskInfomation {
        return dataManager.dataList[indexPath]
    }
}
