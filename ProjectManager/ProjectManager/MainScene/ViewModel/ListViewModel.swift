//
//  ListViewModel.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/19.
//

final class ListViewModel {
    private var tasks: [Task] = []
    
    func appendTask(_ task: Task) {
        tasks.append(task)
    }
}
