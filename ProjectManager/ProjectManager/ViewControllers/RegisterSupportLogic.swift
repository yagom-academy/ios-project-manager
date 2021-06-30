//
//  RegisterSupportLogic.swift
//  ProjectManager
//
//  Created by 김찬우 on 2021/06/30.
//

import UIKit

protocol RegisterSupportLogic {
    func convertToModel() -> TODOModel?
    
    func convertDateToString(_ datePicker: UIDatePicker) -> String
    
    func didHitDoneButton()
}

extension RegisterViewController: RegisterSupportLogic {
    func convertToModel() -> TODOModel? {
        guard let title = registerTitle.text else { return nil }
        let dateString = convertDateToString(datePicker)
        let description = description
        
        return TODOModel(title: title,
                         deadline: dateString,
                         description: description)
    }
    
    func convertDateToString(_ datePicker: UIDatePicker) -> String {
        let formatter = DateFormatter()
        let date: Date = datePicker.date
        
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter.string(from: date)
    }
    
    @objc func didHitDoneButton() {
        self.dismiss(animated: true, completion: nil)
    }
}
