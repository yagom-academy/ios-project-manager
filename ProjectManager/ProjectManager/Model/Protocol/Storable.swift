//
//  Storable.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/31.
//

import Foundation
import RealmSwift

protocol Storable {
    var id: UUID { get set }
    var convertedDictonary: [String: Any] { get }
    var changedToDatabaseObject: Object { get }
    
    static func convertToStorable(_ dict: NSDictionary?) -> Storable?
    static func convertToStorable(_ object: Object) -> Storable?
}
