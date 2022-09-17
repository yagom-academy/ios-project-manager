//
//  DoneViewModel.swift
//  ProjectManager
//
//  Created by 수꿍, 휴 on 2022/09/17.
//

import Foundation

final class DoneViewModel {
    var doneData: Observable<[ProjectUnit]> = Observable([])
    
    var count: Int {
        return doneData.value.count
    }

    let databaseManager: DatabaseLogic

    init(databaseManager: DatabaseLogic) {
        self.databaseManager = databaseManager
        fetchDoneData()
    }

    func delete(_ indexPath: Int) {
        let data = doneData.value.remove(at: indexPath)
        try? databaseManager.delete(id: data.id)
    }

    func fetch(_ indexPath: Int) -> ProjectUnit? {
        doneData.value[indexPath]
    }

    private func fetchDoneData() {
        do {
            try databaseManager.fetchSection("DONE").forEach { project in
                doneData.value.append(project)
            }
        } catch {
            print(error)
        }
    }
}
