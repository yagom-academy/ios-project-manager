//
//  DetailView.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/07.
//

import UIKit

final class DetailView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        setViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.setItems([naviItem], animated: true)
        return navigationBar
    }()
    
    private lazy var naviItem: UINavigationItem = {
        let navigationItem = UINavigationItem()
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = doneButton
        return navigationItem
    }()
    
    private(set) lazy var leftButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.title = "Cancel"
        
        return barButton
    }()
    
    private(set) lazy var doneButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.title = "Done"
        
        return barButton
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleTextField,
                                                      deadlinePicker,
                                                      bodyTextView])
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private(set) lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.preferredFont(forTextStyle: .title2)
        textField.borderStyle = .roundedRect
        textField.layer.shadowOpacity = 0.4
        textField.layer.shadowOffset = CGSize(width: 0, height: 3)
        
        return textField
    }()
    
    private(set) lazy var deadlinePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        
        return datePicker
    }()
    
    private(set) lazy var bodyTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.preferredFont(forTextStyle: .title3)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.systemGray2.cgColor
        textView.layer.shadowOpacity = 0.4
        textView.layer.shadowOffset = CGSize(width: 0, height: 3)
        textView.layer.masksToBounds = false
        
        return textView
    }()
}

// MARK: - view setting func
extension DetailView {
    func setViewContents(_ listItem: ListItem?) {
        guard let listItem = listItem else {
            naviItem.title = ListType.todo.title
            return
        }
        naviItem.title = listItem.type.title
        leftButton.title = "Edit"
        titleTextField.text = listItem.title
        deadlinePicker.date = listItem.deadline
        bodyTextView.text = listItem.body
        changeEditable()
    }
    
    func changeEditable() {
        titleTextField.isEnabled = !titleTextField.isEnabled
        deadlinePicker.isEnabled = !deadlinePicker.isEnabled
        bodyTextView.isEditable = !bodyTextView.isEditable
    }
    
    private func setViewLayout() {
        self.addSubview(navigationBar)
        self.addSubview(mainStackView)
        navigationBar.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
        }
        
        titleTextField.snp.makeConstraints{
            $0.height.equalTo(navigationBar)
        }
        
        mainStackView.snp.makeConstraints{
            $0.top.equalTo(navigationBar.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview().inset(16)
        }
    }
}
