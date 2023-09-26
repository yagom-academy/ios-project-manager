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
    private let placeHolderForTextField = "Title"
    private let placeHolderForTextView = "This is where you type in what to do.\n1000 characters in the limit."
    
    override func viewDidLoad() {
        configureTitle()
        initPlaceHolderForText()
        configureLayout()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }

    private func configureTitle() {
        self.navigationItem.title = "TODO"
    }
    
    private func initPlaceHolderForText() {
        titleTextField.delegate = self
        titleTextField.text = placeHolderForTextField
        titleTextField.textColor = .gray
        descriptionTextView.delegate = self
        descriptionTextView.text = placeHolderForTextView
        descriptionTextView.textColor = .gray
    }
    
    private func configureLayout() {
        titleTextField.layer.shadowColor = UIColor.gray.cgColor
        titleTextField.layer.shadowOpacity = 1
        titleTextField.layer.shadowOffset = CGSize(width: 0, height: 5)
        titleTextField.layer.shadowRadius = 5
        titleTextField.layer.masksToBounds = false
        descriptionTextView.layer.shadowColor = UIColor.gray.cgColor
        descriptionTextView.layer.shadowOpacity = 1
        descriptionTextView.layer.shadowOffset = CGSize(width: 0, height: 5)
        descriptionTextView.layer.shadowRadius = 5
        descriptionTextView.layer.masksToBounds = false
    }
    
    @IBAction func didTapEditButton(_ sender: Any) {
        
    }
    
    @IBAction func didTapDoneButton(_ sender: Any) {
        
    }
}

extension SecondViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if titleTextField.text == placeHolderForTextField {
            titleTextField.text = nil
            titleTextField.textColor = .black
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let title = titleTextField.text, title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            titleTextField.text = placeHolderForTextField
            titleTextField.textColor = .gray
        }
    }
}

extension SecondViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if descriptionTextView.text == placeHolderForTextView {
            descriptionTextView.text = nil
            descriptionTextView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if descriptionTextView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            descriptionTextView.text = placeHolderForTextView
            descriptionTextView.textColor = .gray
        }
    }
}
