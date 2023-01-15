//
//  EditViewModel.swift
//  ProjectManager
//
//  Created by Kyo on 2023/01/14.
//

import Foundation

final class EditViewModel: SelectedDataFetchable {
    let dataManager = DataManager.shared
    
    func fetchSelectData(process: Process, indexPath: IndexPath, completion: (Todo) -> Void) {
        let data: Todo
        data = dataManager.fetchData(process: process)[indexPath.row]
        completion(data)
    }
    
    func updateData(process: Process,
                    title: String,
                    content: String?,
                    date: Date?,
                    indexPath: IndexPath?
    ) {
        let data = Todo(title: title, content: content, deadLine: date)
        guard let indexPath = indexPath else { return }
        dataManager.updateData(process: process, data: data, indexPath: indexPath)
    }
}
