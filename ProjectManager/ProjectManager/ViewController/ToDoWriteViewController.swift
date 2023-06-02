//
//  ToDoWriteViewController.swift
//  ProjectManager
//
//  Created by goat on 2023/05/18.
//

import UIKit

protocol sendToDoListProtocol: AnyObject {
    func sendTodoList(data: ToDoList, isCreatMode: Bool)
}

final class ToDoWriteViewController: UIViewController {
 
    enum Mode {
        case edit
        case create
    }
    
    weak var delegate: sendToDoListProtocol?
    
    private var mode: Mode
    private var fetchedTodoList: ToDoList?
    
    private let navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        return navigationBar
    }()
    
    private let fullStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .bezel
        textField.font = .preferredFont(forTextStyle: .title3)
        switch mode {
        case .create:
            textField.placeholder = "내용을 입력하세요"
        case .edit:
            textField.text = self.fetchedTodoList?.title
        }
        return textField
    }()
    
    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = .preferredFont(forTextStyle: .body)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGray.cgColor
        switch mode {
        case .create:
            textView.text = ""
        case .edit:
            textView.text = self.fetchedTodoList?.description
        }
        return textView
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "en_US")
        return datePicker
    }()
    
    init(mode: Mode, fetchedTodoList: ToDoList? = nil) {
        self.mode = mode
        self.fetchedTodoList = fetchedTodoList
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureViewUI()
    }
    
    // MARK: NavigationBar
    private func configureNavigationBar() {
        navigationItem.title = "TODO"
        
        switch mode {
        case .create:
            let rightButton = UIBarButtonItem(title: "done" , style: .plain, target: self, action: #selector(saveButtonTapped))
            navigationItem.rightBarButtonItem = rightButton
        case .edit:
            let rightButton = UIBarButtonItem(title: "edit" , style: .plain, target: self, action: #selector(saveButtonTapped))
            navigationItem.rightBarButtonItem = rightButton
        }
        
        let leftButton = UIBarButtonItem(title: "cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
        
        navigationItem.leftBarButtonItem = leftButton
        
        navigationBar.setItems([navigationItem], animated: true)
    }
    
    @objc private func saveButtonTapped() {
        saveToDoList()
        self.dismiss(animated: true)
    }
    
    @objc private func cancelButtonTapped() {
        self.dismiss(animated: true)
    }
        
    private func saveToDoList() {
        guard let title = titleTextField.text,
              let description = descriptionTextView.text else { return }
        
        let date = datePicker.date
        let toDoList = ToDoList(title: title, description: description, date: date)
        
        switch mode {
        case .create:
            delegate?.sendTodoList(data: toDoList, isCreatMode: true)
        case .edit:
            delegate?.sendTodoList(data: toDoList, isCreatMode: false)
        }
    }
    
    // MARK: Autolayout
    private func configureViewUI() {
        view.backgroundColor = .white
        view.addSubview(navigationBar)
        view.addSubview(fullStackView)
        
        fullStackView.addArrangedSubview(titleTextField)
        fullStackView.addArrangedSubview(datePicker)
        fullStackView.addArrangedSubview(descriptionTextView)
        
        let safeArea = view.safeAreaLayoutGuide
        
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        fullStackView.translatesAutoresizingMaskIntoConstraints = false
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            navigationBar.topAnchor.constraint(equalTo: safeArea.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            
            fullStackView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            fullStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            fullStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20),
            fullStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            
            titleTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
