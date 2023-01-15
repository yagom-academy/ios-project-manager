//
//  DataProtocol.swift
//  ProjectManager
//
//  Created by Kyo on 2023/01/14.
//

import Foundation

protocol DataUpdatable: AnyObject {
    func updateData(
        process: Process,
        title: String,
        content: String?,
        date: Date?,
        indexPath: IndexPath?
    )
}

protocol SelectedDataFetchable: DataUpdatable {
    func fetchSelectData(process: Process, indexPath: IndexPath, completion: (Todo) -> Void)
}
