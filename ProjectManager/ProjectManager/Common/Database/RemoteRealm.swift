//
//  RealmManager.swift
//  ProjectManager
//
//  Created by seohyeon park on 2022/09/27.
//

import RealmSwift
import Combine

class RemoteRealm: ObservableObject {
    private let app: App = App(id: "application-0-rynak")
    private var realm: Realm?

    var databaseManager: DatabaseManagerRealm?
    var data = [TaskModel]()

    func initialize() {
        Task {
            guard let user = try? await getUser() else {
                print("❌ 유저 못 가져옴")
                return
            }

            print("🤯 \(user.id)")
            await openSyncedRealm(user: user)

            guard realm?.subscriptions != nil else {
                let subscriptions = realm?.subscriptions
                try await subscriptions?.update {
                    subscriptions?.append(QuerySubscription<RealmDatabaseModel>(name: "all_RealmDatabaseModels"))
                }
                return
            }
        }
    }

    private func getUser() async throws -> User {
        let user = try await app.login(credentials: .emailPassword(email: "admin@test.com", password: "test1234"))
        return user
    }

    private func openSyncedRealm(user: User) async {
        do {
            var config = user.flexibleSyncConfiguration { sub in
                sub.append(QuerySubscription<RealmDatabaseModel> {
                    $0.ownerId == user.id
                })
            }

            config.objectTypes = [RealmDatabaseModel.self]
            realm = try await Realm(configuration: config)
            databaseManager = DatabaseManagerRealm(realm: realm)
        } catch {
            print("💖 Error opening realm: \(error.localizedDescription)")
        }
    }
}
