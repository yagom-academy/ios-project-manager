//
//  ModalViewContoller.swift
//  ProjectManager
//
//  Created by Baem on 2023/01/13.
//

import UIKit

final class ModalViewContoller: UIViewController {
    enum WriteMode {
        case create
        case edit
    }
    
    private var writeMode: WriteMode
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Title"
        textField.font = .preferredFont(forTextStyle: .title1)
        textField.backgroundColor = .systemBackground
        
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.systemGray3.cgColor
        textField.layer.shadowColor = UIColor.systemPink.cgColor
        textField.layer.masksToBounds = false
        textField.layer.shadowOffset = CGSize(width: 2, height: 4)
        textField.layer.shadowRadius = 3
        textField.layer.shadowOpacity = 0.5
        
        return textField
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
        
        return datePicker
    }()
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.font = .preferredFont(forTextStyle: .title3)
        
        textView.layer.borderWidth = 2
        textView.layer.borderColor = UIColor.systemGray3.cgColor
        textView.layer.shadowColor = UIColor.systemPink.cgColor
        textView.layer.masksToBounds = false
        textView.layer.shadowOffset = CGSize(width: 2, height: 4)
        textView.layer.shadowRadius = 3
        textView.layer.shadowOpacity = 0.5
        
        return textView
    }()
    
    init(mode: WriteMode) {
        self.writeMode = mode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        configureLayout()
        setNavigation()
    }
    
    private func setNavigation() {
        navigationItem.title = "TODO"
        
        switch writeMode {
        case .create:
            let leftBarButton = UIBarButtonItem(
                barButtonSystemItem: .cancel,
                target: self,
                action: #selector(tapCancelButton)
            )
            navigationItem.leftBarButtonItem = leftBarButton
        case .edit:
            let leftBarButton = UIBarButtonItem(
                barButtonSystemItem: .edit,
                target: self,
                action: #selector(tapEditButton)
            )
            navigationItem.leftBarButtonItem = leftBarButton
        }
        
        let rightBarButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(tapRightButton)
        )
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    // TODO: -Left Right Button 입력 함수 구현
    @objc private func tapCancelButton() {
        dismiss(animated: true)
    }
    
    @objc private func tapEditButton() {
        dismiss(animated: true)
    }
    
    @objc private func tapRightButton() {
        dismiss(animated: true)
    }
    
    private func configureLayout() {
        [textField, datePicker, textView].forEach {
            self.view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let safeArea = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: safeArea.topAnchor),
            textField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8),
            textField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -8),
            
            datePicker.topAnchor.constraint(equalTo: textField.bottomAnchor),
            datePicker.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8),
            datePicker.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -8),
            
            textView.topAnchor.constraint(equalTo: datePicker.bottomAnchor),
            textView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8),
            textView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -8),
            textView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -8)
        ])
    }
}
