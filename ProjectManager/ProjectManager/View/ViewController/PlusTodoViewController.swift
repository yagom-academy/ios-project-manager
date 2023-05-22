//
//  PlusTodoViewController.swift
//  ProjectManager
//
//  Created by 리지 on 2023/05/17.
//

import UIKit
import Combine

final class PlusTodoViewController: UIViewController {
    
    weak var delegate: SavingItemDelegate?
    private let plusTodoViewModel: PlusTodoViewModel?
    private let selectedIndexPath: IndexPath?
    
    init(plusTodoViewModel: PlusTodoViewModel?, selectedIndexPath: IndexPath?) {
        self.plusTodoViewModel = plusTodoViewModel
        self.selectedIndexPath = selectedIndexPath
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let todoView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
        
        return view
    }()
    
    private let navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.isTranslucent = false
        navigationBar.backgroundColor = .systemBackground
        
        return navigationBar
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private let titleField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        textField.textColor = UIColor.black
        textField.backgroundColor = UIColor.white
        
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.shadowOffset = CGSize(width: 0, height: 3)
        textField.layer.shadowOpacity = 0.5
        textField.layer.shadowRadius = 3.0
        
        return textField
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: Locale.current.identifier)
        
        return datePicker
    }()
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.textColor = UIColor.black
        textView.backgroundColor = UIColor.white
        
        textView.layer.masksToBounds = false
        textView.layer.shadowColor = UIColor.black.cgColor
        textView.layer.shadowOffset = CGSize(width: 0, height: 3)
        textView.layer.shadowOpacity = 0.5
        textView.layer.shadowRadius = 3.0
        
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTodoView()
        configureNavigationBar()
        configureStackView()
        editTodoItem()
    }
    
    private func setUpTodoView() {
        view.addSubview(todoView)
        todoView.addSubview(navigationBar)
        todoView.addSubview(stackView)
      
        todoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            todoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            todoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            todoView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            todoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
  
    private func configureNavigationBar() {
        let title = "TODO"
        let done = "Done"
        var leftButtonTitle = ""

        switch plusTodoViewModel?.mode {
        case .create:
            leftButtonTitle = "Cancel"
        default:
            leftButtonTitle = "Edit"
        }
        
        let doneButton = UIBarButtonItem(title: done, style: .done, target: self, action: #selector(doneButtonTapped))
        let leftButton = UIBarButtonItem(title: leftButtonTitle, style: .plain, target: self, action: #selector(leftButtonTapped))
        
        let navigationItem = UINavigationItem(title: title)
        navigationItem.rightBarButtonItem = doneButton
        navigationItem.leftBarButtonItem = leftButton
        navigationBar.items = [navigationItem]
        
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: todoView.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: todoView.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: todoView.trailingAnchor)
        ])
    }
    
    @objc private func doneButtonTapped() {
        switch plusTodoViewModel?.mode {
        case .create:
            guard let item = setUpItem() else { return }
            self.delegate?.addItem(item)
            self.dismiss(animated: false)
        default:
            self.dismiss(animated: false)
        }
    }
    
    @objc private func leftButtonTapped() {
        switch plusTodoViewModel?.mode {
        case .create:
            self.dismiss(animated: false)
        default:
            guard let item = setUpItem() else { return }
            guard let selectedIndexPath = self.selectedIndexPath else { return }
            self.delegate?.updateItem(at: selectedIndexPath, by: item)
        }
    }
    
    private func setUpItem() -> TodoItem? {
        guard let title = self.titleField.text,
              let body = self.textView.text else { return nil }
        
        let date = self.datePicker.date
        let item = TodoItem(title: title, body: body, date: date)
        
        return item
    }

    private func configureStackView() {
        stackView.addArrangedSubview(titleField)
        stackView.addArrangedSubview(datePicker)
        stackView.addArrangedSubview(textView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor, constant: -15),
            stackView.bottomAnchor.constraint(equalTo: todoView.bottomAnchor, constant: -20)
        ])
    }
    
    private func editTodoItem() {
        if let item = self.plusTodoViewModel?.todoItem {
            self.titleField.text = item.title
            self.textView.text = item.body
            self.datePicker.date = item.date
        }
    }
}
