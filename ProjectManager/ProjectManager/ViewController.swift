//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var titleNavigationBar: UINavigationBar!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleNavigationBar.topItem?.title = "Project Manager"
    }
    
    @IBAction func tappedAddButton(_ sender: Any) {
        guard let sheetViewController = self.storyboard?.instantiateViewController(identifier: "SheetViewController") else {
            return
        }
        
        sheetViewController.modalPresentationStyle = .formSheet
        self.present(sheetViewController, animated: true, completion: nil)
    }
    

}

class SheetViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var deadlineDatePicker: UIDatePicker!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tappedDoneButton(_ sender: Any) {
        /// 새로운 글 등록 or 기존의 글 수정
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func tappedCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
