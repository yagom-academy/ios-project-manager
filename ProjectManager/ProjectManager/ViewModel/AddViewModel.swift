//
//  AddViewModel.swift
//  ProjectManager
//
//  Created by Kyo on 2023/01/14.
//

import Foundation

final class AddViewModel: DataUpdatable {
    let dataManager = DataManager.shared
    
    func updateData(
        process: Process,
        title: String,
        content: String?,
        date: Date?,
        indexPath: IndexPath?
    ) {
        let data = Todo(title: title, content: content, deadLine: date)
        dataManager.appendData(process: .todo, data: data)
    }
}
