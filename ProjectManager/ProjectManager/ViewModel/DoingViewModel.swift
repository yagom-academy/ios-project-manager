//
//  DoingViewModel.swift
//  ProjectManager
//
//  Created by 수꿍, 휴 on 2022/09/17.
//

import Foundation

final class DoingViewModel: Readjustable, Editable {
    var doingData: Observable<[ProjectUnit]> = Observable([])
    
    var count: Int {
        return doingData.value.count
    }

    let databaseManager: DatabaseLogic

    init(databaseManager: DatabaseLogic) {
        self.databaseManager = databaseManager
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(addData(_:)),
            name: Notification.Name("TODOtoDOING"),
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(addData(_:)),
            name: Notification.Name("DONEtoDOING"),
            object: nil
        )
        fetchDoingData()
    }
    
    @objc func addData(_ notification: Notification) {
        guard var projectUnit = notification.object as? ProjectUnit else {
            return
        }
        
        projectUnit.section = Section.doing
        
        doingData.value.append(projectUnit)
        
        do {
            try databaseManager.update(data: projectUnit)
        } catch {
            print(error)
        }
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
            try databaseManager.fetchSection(Section.doing).forEach { project in
                doingData.value.append(project)
            }
        } catch {
            print(error)
        }
    }
    
    func readjust(index: Int, section: String) {
        let data = doingData.value.remove(at: index)

        switch section {
        case Section.todo:
            NotificationCenter.default.post(name: Notification.Name("DOINGtoTODO"), object: data)
        case Section.done:
            NotificationCenter.default.post(name: Notification.Name("DOINGtoDONE"), object: data)
        default:
            return
        }
    }

    func edit(
        indexPath: Int,
        title: String,
        body: String,
        date: Date
    ) {
        var data = doingData.value[indexPath]
        data.title = title
        data.body = body
        data.deadLine = date
        
        doingData.value[indexPath] = data
        do {
            try databaseManager.update(data: data)
        } catch {
            print(error)
        }
    }

    func isPassDeadLine(_ deadLine: Date) -> Bool {
        if deadLine < Date() {
            return true
        }

        return false
    }
}
