//
//  FirestoreService.swift
//  ProjectManager
//
//  Created by Lee Seung-Jae on 2022/03/16.
//

import Foundation
import RxSwift
import FirebaseFirestore

class FirestoreService: NetworkService {
    private let database = Firestore.firestore()

    func create(_ schedule: Schedule) -> Completable {
        return Completable.create { completable in
            self.database.collection("schedules").document(schedule.id.uuidString).setData(schedule.makeEntity()) { err in
                if let err = err {
                    completable(.error(err))
                } else {
                    completable(.completed)
                }
            }
            return Disposables.create()
        }
    }

    func delete(_ scheduleID: UUID) -> Completable {
        return Completable.create { completable in
            let item = self.database.collection("schedules").document(scheduleID.uuidString)
            item.delete { err in
                if let err = err {
                    completable(.error(err))
                } else {
                    completable(.completed)
                }
            }
            return Disposables.create()
        }
    }

    func update(_ schedule: Schedule) -> Completable {
        return Completable.create { completable in
            self.database.collection("schedules").document(schedule.id.uuidString).setData(schedule.makeEntity()) { err in
                if let err = err {
                    completable(.error(err))
                } else {
                    completable(.completed)
                }
            }
            return Disposables.create()
        }
    }

    func fetch() -> Single<[Schedule]> {
        return Single.create { single in
            self.database.collection("schedules").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    single(.failure(err))
                } else {
                    let schedules = querySnapshot!.documents.map { Schedule(document: $0.data()) }
                    single(.success(schedules))
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")

                    }
                }
            }
            return Disposables.create()
        }
    }
}

private extension FirestoreService {

}

extension Schedule {
    func makeEntity() -> [String: Any] {
        return [
            "id": self.id.uuidString,
            "title": self.title,
            "body": self.body,
            "progress": self.progress.description,
            "dueDate": self.dueDate,
            "lastUpdated": self.lastUpdated
        ]
    }

    init(document: [String: Any]) {
        self.id = UUID(uuidString: document["id"] as! String)!
        self.title = document["title"] as! String
        self.body = document["body"] as! String
        switch document["progress"] as! String {
        case "TODO":
            self.progress = Progress.todo
        case "DOING":
            self.progress = Progress.doing
        case "DONE":
            self.progress = Progress.done
        default:
            self.progress = Progress.todo
        }
        let dueDateStamp = document["dueDate"] as! Timestamp
        self.dueDate = dueDateStamp.dateValue()
        let lastUpdatedStamp = document["lastUpdated"] as! Timestamp
        self.lastUpdated = lastUpdatedStamp.dateValue()
    }
}
