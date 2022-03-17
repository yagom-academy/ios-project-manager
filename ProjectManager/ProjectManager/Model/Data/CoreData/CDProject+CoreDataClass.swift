//
//  CDProject+CoreDataClass.swift
//  ProjectManager
//
//  Created by 1 on 2022/03/17.
//
//

import Foundation
import CoreData

@objc(CDProject)
public class CDProject: NSManagedObject {
    var status: Status? {
        guard let statusString = statusString else {
            return nil
        }
        
        return Status(rawValue: statusString)
    }
}
