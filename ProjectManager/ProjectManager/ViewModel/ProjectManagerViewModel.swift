//
//  ProjectManagerViewModel.swift
//  ProjectManager
//
//  Created by Finnn on 2022/09/08.
//

import Foundation
import RxSwift

class ProjectManagerViewModel {
    
    // MARK: - Properties
    
    private var allTodoList = BehaviorSubject<[Todo]>(value: [])
    // MARK: - Life Cycle
    
    init() {
        let sampleData = Todo.generateSampleData(
            count: 20,
            maxBodyLine: 10,
            startDate: "2022-09-01",
            endData: "2022-09-30"
        )
        allTodoList.onNext(sampleData)
    }
}
