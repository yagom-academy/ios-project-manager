//
//  ModelMakable.swift
//  ProjectManager
//
//  Created by YB on 2021/07/08.
//

import Foundation

protocol ModelMakable {
    func convertToModel(title: String?,
                        date: Double,
                        myDescription: String,
                        status: String,
                        identifier: String) -> Task?
    
    func convertDateToDouble(_ date: Date) -> Double
}

extension ModelMakable {
    
    func convertToModel(title: String?,
                        date: Double,
                        myDescription: String,
                        status: String,
                        identifier: String) -> Task?
    {
        guard let title = title else { return nil }
        
        return Task(title: title,
                         date: date,
                         myDescription: myDescription,
                         status: status,
                         identifier: identifier)
    }
    
    func convertDateToDouble(_ date: Date) -> Double {
        let unixStamp = date.timeIntervalSince1970
        
        return unixStamp
    }
}
