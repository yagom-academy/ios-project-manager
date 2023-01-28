//
//  DatabaseManager.swift
//  ProjectManager
//
//  Created by junho lee on 2023/01/27.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class DatabaseManager {
    private lazy var database = Firestore.firestore()

    func fetchProjectTodos(completion: @escaping ([ProjectTodo]) -> Void) {
        database.collection(Constants.databaseCollection).getDocuments { querySnapshot, error in
            if let error {
                print(error.localizedDescription)
                completion([])
            }
            guard let documents = querySnapshot?.documents else { return
                completion([])
            }
            var projectTodos = [ProjectTodo]()
            documents.forEach { document in
                if let data = try? document.data(as: ProjectTodo.self) {
                    projectTodos.append(data)
                }
            }
            completion(projectTodos)
        }
    }

    func add(_ projectTodo: ProjectTodo) {
        do {
            let reference = database.collection(Constants.databaseCollection).document(projectTodo.id.uuidString)
            try reference.setData(from: projectTodo)
        } catch {
            print(error.localizedDescription)
        }
    }

    func updateAll(_ projectTodos: [ProjectTodo]) {
        projectTodos.forEach { projectTodo in
            add(projectTodo)
        }
    }

    func update(_ projectTodo: ProjectTodo) {
        let reference = database.collection(Constants.databaseCollection).document(projectTodo.id.uuidString)
        reference.updateData([
            Constants.databaseStateField: projectTodo.state.rawValue,
            Constants.databaseTitleField: projectTodo.title,
            Constants.databaseDescriptionField: projectTodo.description,
            Constants.databaseDueDateField: projectTodo.dueDate
        ]) { error in
            if let error {
                print(error.localizedDescription)
            }
        }
    }

    func delete(_ projectTodoID: UUID) {
        database.collection(Constants.databaseCollection).document(projectTodoID.uuidString).delete { error in
            if let error {
                print(error.localizedDescription)
            }
        }
    }
}
