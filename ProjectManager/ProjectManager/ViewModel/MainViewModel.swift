//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by Kyo on 2023/01/12.
//

import Foundation

final class MainViewModel {
    private var todoData: [Todo] = []
    private var doingData: [Todo] = []
    private var doneData: [Todo] = []
    
    func fetchData(process: Process) -> [Todo] {
        switch process {
        case .todo:
            return todoData
        case .doing:
            return doingData
        case .done:
            return doneData
        }
    }
}
