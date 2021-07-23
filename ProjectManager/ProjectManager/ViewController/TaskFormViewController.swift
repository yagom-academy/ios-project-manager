//
//  TaskFormViewController.swift
//  ProjectManager
//
//  Created by steven on 7/23/21.
//

import UIKit

class TaskFormViewController: UIViewController {
    var type: String?
    
    convenience init() {
        print("convenience init")
        self.init(type: nil)
    }
    
    init(type: String?) {
        print("init")
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Title"
        textField.font = UIFont.preferredFont(forTextStyle: .title1)
        return textField
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        return datePicker
    }()
    
    private lazy var contentTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleTextField, datePicker, contentTextView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fill
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // leftbutton
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "cancel", style: .plain, target: self, action: nil)
        // rightbutton
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "done", style: .plain, target: self, action: nil)
        
        self.navigationItem.title = "TODO"
        
        self.view.backgroundColor = .systemBackground
        view.addSubview(stackView)
        configureConstraints()
    }
    
    private func configureConstraints() {
        let safeArea = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -8),
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10)
        ])
    }
    
    
    
}
