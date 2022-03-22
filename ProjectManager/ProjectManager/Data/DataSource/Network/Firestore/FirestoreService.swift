//
//  FirestoreService.swift
//  ProjectManager
//
//  Created by Lee Seung-Jae on 2022/03/16.
//

import Foundation
import RxSwift
import FirebaseFirestore

final class FirestoreService: NetworkService {
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
            self.database.collection("schedules")
                .document(schedule.id.uuidString)
                .setData(schedule.makeEntity()) { err in
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
                    guard let querySnapshot = querySnapshot else {
                        single(.success([]))
                        return
                    }
                    let schedules = querySnapshot.documents
                        .compactMap { Schedule(document: $0.data()) }
                    single(.success(schedules))

                }
            }
            return Disposables.create()
        }
    }
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

    init?(document: [String: Any]) {
        guard let idString = document["id"] as? String,
              let id = UUID(uuidString: idString),
              let title = document["title"] as? String,
              let body = document["body"] as? String,
              let dueDateStamp = document["dueDate"] as? Timestamp,
              let lastUpdatedStamp = document["lastUpdated"] as? Timestamp,
              let progressString = document["progress"] as? String,
              let progress = Progress(rawValue: progressString)
        else {
            return nil
        }

        self.id = id
        self.title = title
        self.body = body
        self.progress = progress
        self.dueDate = dueDateStamp.dateValue()
        self.lastUpdated = lastUpdatedStamp.dateValue()
    }
}
