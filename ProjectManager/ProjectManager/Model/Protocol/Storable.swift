//
//  Storable.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/31.
//

import Foundation
import RealmSwift

protocol Storable {
    var convertedDictonary: [String: Any] { get }
    var changedToDatabaseObject: Object { get }
    
    func convertToStorable(_ dict: NSDictionary?) -> Storable?
    func convertToStorable(_ object: Object) -> Storable?
}
