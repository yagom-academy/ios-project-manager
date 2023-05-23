//
//  ModalViewController.swift
//  ProjectManager
//
//  Created by kimseongjun on 2023/05/22.
//

import UIKit

class ModalViewController: UIViewController {
    let mainViewModel: MainViewModel?
    
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "제목을 입력해주세요"
        textField.borderStyle = .none
        textField.backgroundColor = .systemBackground
        textField.layer.shadowColor = UIColor.systemGray2.cgColor
        textField.layer.shadowOffset = CGSize(width: 0, height: 5)
        textField.layer.shadowOpacity = 1
        textField.layer.shadowRadius = 5.0
        textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private let datePickerView: UIDatePicker = {
        let pickerView = UIDatePicker()
        pickerView.preferredDatePickerStyle = .wheels
        pickerView.locale = Locale(identifier: "ko_KR")
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        return pickerView
    }()
    
    private let contentTextView: UITextView = {
        let contentTextView = UITextView()
        
        contentTextView.textColor = .black
        contentTextView.backgroundColor = .systemBackground
        contentTextView.layer.masksToBounds = false
        contentTextView.layer.shadowColor = UIColor.systemGray2.cgColor
        contentTextView.layer.shadowOffset = CGSize(width: 0, height: 5)
        contentTextView.layer.shadowOpacity = 1
        contentTextView.layer.shadowRadius = 5.0
        contentTextView.translatesAutoresizingMaskIntoConstraints = false
        
        return contentTextView
    }()
    
    init(viewModel: MainViewModel) {
        self.mainViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "TODO"
        configureUI()
        configureBarButton()
    }
    
    private func configureUI() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.layer.cornerRadius = 20
        
        view.addSubview(titleTextField)
        view.addSubview(datePickerView)
        view.addSubview(contentTextView)
        
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 5),
            titleTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            titleTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
            
            datePickerView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            datePickerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            datePickerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            
            contentTextView.topAnchor.constraint(equalTo: datePickerView.bottomAnchor, constant: 20),
            contentTextView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            contentTextView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            contentTextView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20),
        ])
    }
    
    private func configureBarButton() {
        let rightButton = UIBarButtonItem(title: "Done",
                                          style: .done,
                                          target: self,
                                          action: #selector(tapDoneButton))
        
        let leftButton = UIBarButtonItem(title: "Cancel",
                                         style: .done,
                                         target: self,
                                         action: #selector(tapCancelButton))
        
        self.navigationItem.rightBarButtonItem = rightButton
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    @objc
    private func tapEditButton() {
        
    }
    
    @objc
    private func tapDoneButton() {
        guard let schedule = mainViewModel?.createSchedule(titleText: titleTextField.text,
                                                contentText: contentTextView.text,
                                                expirationDate: Date()) else { return }
        mainViewModel?.addTodoSchedule(schedule)
        
        dismiss(animated: true)
        print(mainViewModel?.todoSchedules)
        
    }
    
    @objc
    private func tapCancelButton() {
        dismiss(animated: true)
    }
}
