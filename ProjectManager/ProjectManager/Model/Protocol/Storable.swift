//
//  Storable.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/31.
//

import Foundation
import RealmSwift

protocol Storable {
    var convertedDictonary: [String: Any] { get set }
    var changedToDatabaseObject: Object { get set }
    
    func convertToStorable(_ dict: NSDictionary?) -> Storable
    func convertToStorable(_ object: Object) -> Storable
}
