//
//  RealmUserObject.swift
//  ProjectManager
//
//  Created by 김민성 on 2023/10/04.
//

import Foundation
import RealmSwift

final class UserObject: Object {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var email: String
    
    convenience init(id: UUID = UUID(), email: String) {
        self.init()
        self.id = id
        self.email = email
    }
}
