//
//  AddViewController.swift
//  ProjectManager
//
//  Created by 강경 on 2021/06/29.
//

import UIKit

class AddViewController: UIViewController {
    private let dateConverter = DateConverter()
    
    @IBOutlet weak var newTitle: UITextField!
    @IBOutlet weak var newDate: UIDatePicker!
    @IBOutlet weak var newContent: UITextView!
    
    @IBAction func clickDoneButton(_ sender: Any) {
        let title: String = newTitle.text ?? ""
        let date: Double = dateConverter.dateToNumber(date: newDate.date)
        let content: String = newContent.text
        
        print("title: \(title), date: \(date), content: \(content)")
    }
}
