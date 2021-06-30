//
//  RegisterSupportLogic.swift
//  ProjectManager
//
//  Created by 김찬우 on 2021/06/30.
//

import UIKit

protocol RegisterSupportLogic {
    func convertToModel(title: String?,
                        dateString: String,
                        description: String) -> TODOModel?
    
    func convertDateToString(_ date: Date) -> String
}

extension RegisterViewController: RegisterSupportLogic {
    func convertToModel(title: String?, dateString: String, description: String) -> TODOModel? {
        guard let title = title else { return nil }
        
        return TODOModel(title: title,
                         deadline: dateString,
                         description: description)
    }
    
    func convertDateToString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter.string(from: date)
    }
}
