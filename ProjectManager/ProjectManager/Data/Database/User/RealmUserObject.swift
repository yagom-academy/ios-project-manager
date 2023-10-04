//
//  RealmUserObject.swift
//  ProjectManager
//
//  Created by 김민성 on 2023/10/04.
//

import Foundation
import RealmSwift

final class RealmUserObject: Object {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var email: String?
    
    convenience init(id: UUID = UUID(), email: String? = nil) {
        self.init()
        self.id = id
        self.email = email
    }
}
