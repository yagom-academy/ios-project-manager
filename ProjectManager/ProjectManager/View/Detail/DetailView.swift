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
        navigationItem.leftBarButtonItem = cancleButton
        navigationItem.rightBarButtonItem = doneButton
        return navigationItem
    }()
    
    private lazy var cancleButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.title = "Cancel"
        
        return barButton
    }()
    
    private lazy var doneButton: UIBarButtonItem = {
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
    
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.preferredFont(forTextStyle: .title2)
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    private lazy var deadlinePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        
        return datePicker
    }()
    
    private lazy var bodyTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.preferredFont(forTextStyle: .title3)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.systemGray2.cgColor
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
        cancleButton.title = "Edit"
        titleTextField.text = listItem.title
        deadlinePicker.date = listItem.deadline
        bodyTextView.text = listItem.body
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
