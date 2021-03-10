//
//  DetailViewController.swift
//  ProjectManager
//
//  Created by 리나 on 2021/03/11.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK: - Property
    
    var isNew: Bool = false

    // MARK: - Outlet
    
    let titleTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    let bodyTextView: UITextView = {
       let textView = UITextView()
        return textView
    }()
    
    let datePicker: UIDatePicker = {
       let datePicker = UIDatePicker()
        return datePicker
    }()
    
}
