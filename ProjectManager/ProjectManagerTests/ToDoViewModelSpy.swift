//
//  ToDoViewModelSpy.swift
//  ProjectManagerTests
//
//  Created by 수꿍, 휴 on 2022/09/24.
//

@testable import ProjectManager
import Foundation

final class ToDoViewModelSpy: CommonViewModelLogic, ContentAddible, ContentEditable, StatusChangable {
    let identifier: String = "TestToDo"
    let data: Observable<[ProjectUnit]> = Observable([])
    let databaseManager: LocalDatabaseManager

    var numberOfData: Int {
        return data.value.count
    }
    var callCountOfData: Int = 0

    var changeMethodCalled: Int = 0
    var changeMethodIndexParam: Int?
    var changeMethodStatusParam: String?

    var deleteMethodCalled: Int = 0
    var deleteMethodIndexParam: Int?

    var editMethodCalled: Int = 0
    var editMethodIndexParam: Int?
    var editMethodTitleParam: String?
    var editMethodBodyParam: String?
    var editMethodDateParam: Date?

    var addContentMethodCalled: Int = 0
    var addContentMethodTitleParam: String?
    var addContentMethodBodyParam: String?
    var addContentMethodDateParam: Date?

    var message: String = "" {
        didSet {
            guard let showAlert = self.showAlert else {
                return
            }
            showAlert()
        }
    }

    var showAlert: (() -> Void)?

    init(databaseManager: LocalDatabaseManager) {
        self.databaseManager = databaseManager
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(addData(_:)),
            name: Notification.Name("TestDoing->TestToDo"),
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(addData(_:)),
            name: Notification.Name("TestDone->TestToDo"),
            object: nil
        )
        subscribe()
    }

    convenience init() {
        self.init(databaseManager: LocalDatabaseManager(isInMemory: true))
    }

    @objc func addData(_ notification: Notification) {
        guard var projectUnit = notification.object as? ProjectUnit else {
            return
        }

        projectUnit.section = identifier

        self.data.value.append(projectUnit)
    }

    func subscribe() {
        data.subscribe { [weak self] _ in
            self?.callCountOfData += 1
        }
    }

    func change(index: Int, status: String) {
        changeMethodCalled += 1
        changeMethodIndexParam = index
        changeMethodStatusParam = status

        let data = data.value.remove(at: index)

        switch status {
        case "TestDoing":
            NotificationCenter.default.post(name: Notification.Name("TestToDO->TestDoing"), object: data)
        case "TestDone":
            NotificationCenter.default.post(name: Notification.Name("TestToDO->TestDone"), object: data)
        default:
            return
        }
    }

    func delete(_ indexPath: Int) {
        deleteMethodCalled += 1
        deleteMethodIndexParam = indexPath

        let data = data.value.remove(at: indexPath)

        do {
            try databaseManager.delete(id: data.id)
        } catch {
            message = "Delete Error"
        }
    }

    func edit(
        indexPath: Int,
        title: String,
        body: String,
        date: Date
    ) {
        editMethodCalled += 1
        editMethodIndexParam = indexPath
        editMethodTitleParam = title
        editMethodBodyParam = body
        editMethodDateParam = date

        var data = data.value[indexPath]
        data.title = title
        data.body = body
        data.deadLine = date

        self.data.value[indexPath] = data
        do {
            try databaseManager.update(data: data)
        } catch {
            message = "Edit Error"
        }
    }

    func addContent(title: String, body: String, date: Date) {
        addContentMethodCalled += 1
        addContentMethodTitleParam = title
        addContentMethodBodyParam = body
        addContentMethodDateParam = date

        let project = ProjectUnit(
            id: UUID(),
            title: title,
            body: body,
            section: identifier,
            deadLine: date
        )
        data.value.append(project)
        do {
            try databaseManager.create(data: project)
        } catch {
            message = "Add Entity Error"
        }
    }
}
