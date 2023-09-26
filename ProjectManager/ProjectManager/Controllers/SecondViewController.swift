//
//  SecondViewController.swift
//  ProjectManager
//
//  Created by Jusbug on 2023/09/23.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        configureTitle()
        initPlaceHolderForTextField()
    }

    private func configureTitle() {
        self.navigationItem.title = "TODO"
    }
    
    private func initPlaceHolderForTextField() {
        titleTextField.delegate = self
        titleTextField.text = "Title"
        titleTextField.textColor = .gray
    }
    
    @IBAction func didTapEditButton(_ sender: Any) {
        
    }
    
    @IBAction func didTapDoneButton(_ sender: Any) {
        
    }
}

extension SecondViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        return true
    }
}
