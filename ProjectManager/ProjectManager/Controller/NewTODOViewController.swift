//
//  NewTODOViewController.swift
//  ProjectManager
//
//  Created by idinaloq on 2023/09/22.
//

import UIKit

final class NewTODOViewController: UIViewController {
    private let datePicker: UIDatePicker = UIDatePicker()
    private var textModel: ProjectManager = ProjectManager()
    private var isEditMode: Bool
    var delegate: NewTODOViewControllerDelegate?

    
    private let titleTextField: UITextField = {
        let textField: UITextField = UITextField()
        textField.placeholder = "Title"
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .green
        
        return textField
    }()
    
    private let bodyTextView: UITextView = {
        let textView: UITextView = UITextView()
        textView.backgroundColor = .brown
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureUI()
        configureDatePicker()
        configureLayout()
        
    }
    
    init(isEditMode: Bool) {
        self.isEditMode = isEditMode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureDatePicker() {
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.timeZone = .autoupdatingCurrent
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.addTarget(self, action: #selector(selectDatePicker), for: .allEvents)
        
        
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        bodyTextView.delegate = self
        titleTextField.delegate = self
        view.addSubview(titleTextField)
        view.addSubview(datePicker)
        view.addSubview(bodyTextView)
    }
    
    private func configureNavigation() {

        let cancelButton: UIBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(tappedCancelButton))
        let doneButton: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(tappedDoneButton))
        let editButton: UIBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(tappedEditButton))
        
        if isEditMode {
            navigationItem.leftBarButtonItem = editButton
        } else {
            navigationItem.leftBarButtonItem = cancelButton
        }
        navigationItem.rightBarButtonItem = doneButton
        navigationItem.title = "여기에 제목불러오기"
    }
    
    @objc private func tappedEditButton() {
        //edit버튼누르면 수정할 수 있다는게, 수정 이전에는 아무것도 선택이 안되어야 하는 건가?
    }
    
    @objc private func tappedCancelButton() {
        dismiss(animated: true)
    }
    
    @objc private func tappedDoneButton() {
        if textModel.deadline == nil {
            textModel.deadline = Date()
        }
        delegate?.getTextModel(textModel: textModel)
        dismiss(animated: true)
    }
    
    @objc private func selectDatePicker() {
        textModel.deadline = datePicker.date
        print(textModel.deadline as Any)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            titleTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            titleTextField.heightAnchor.constraint(equalToConstant: 64),
            
            datePicker.topAnchor.constraint(equalTo: titleTextField.bottomAnchor),
            datePicker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            
            bodyTextView.heightAnchor.constraint(equalToConstant: 300),
            bodyTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            bodyTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            bodyTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
}

extension NewTODOViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        textModel.title = textField.text
    }
}


extension NewTODOViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        textModel.body = textView.text
    }

}


protocol NewTODOViewControllerDelegate: AnyObject {
    func getTextModel(textModel: ProjectManager)
}


