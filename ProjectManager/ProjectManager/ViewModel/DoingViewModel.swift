//
//  DoingViewModel.swift
//  ProjectManager
//
//  Created by 수꿍, 휴 on 2022/09/17.
//

import Foundation

final class DoingViewModel {
    var doingData: Observable<[ProjectUnit]> = Observable([])
    
    var count: Int {
        return doingData.value.count
    }

    let databaseManager: DatabaseLogic

    init(databaseManager: DatabaseLogic) {
        self.databaseManager = databaseManager
        fetchDoingData()
    }

    func delete(_ indexPath: Int) {
        let data = doingData.value.remove(at: indexPath)
        try? databaseManager.delete(id: data.id)
    }

    func fetch(_ indexPath: Int) -> ProjectUnit? {
        doingData.value[indexPath]
    }

    private func fetchDoingData() {
        do {
            try databaseManager.fetchSection("DOING").forEach { project in
                doingData.value.append(project)
            }
        } catch {
            print(error)
        }
    }
}
