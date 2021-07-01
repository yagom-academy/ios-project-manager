//
//  RegisterSupportLogic.swift
//  ProjectManager
//
//  Created by 김찬우 on 2021/06/30.
//

import UIKit

protocol RegisterSupportLogic {
    func convertToModel(title: String?,
                        date: Double,
                        description: String,
                        status: String,
                        identifier: String) -> TODOModel?
    
    func convertDateToString(_ date: Date) -> Double
}

extension RegisterViewController: RegisterSupportLogic {
    func convertToModel(title: String?,
                        date: Double,
                        description: String,
                        status: String,
                        identifier: String) -> TODOModel? {
        guard let title = title else { return nil }
        
        return TODOModel(title: title,
                         date: date,
                         description: description,
                         status: status,
                         identifier: identifier)
    }
    
    func convertDateToString(_ date: Date) -> Double {
        let unixStamp = date.timeIntervalSince1970
        
        return unixStamp
    }
}
