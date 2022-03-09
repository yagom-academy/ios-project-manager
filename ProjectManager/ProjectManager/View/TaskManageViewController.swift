//
//  TaskManageViewController.swift
//  ProjectManager
//
//  Created by 이차민 on 2022/03/09.
//

import UIKit

private enum Design {
    static let topMargin: CGFloat = 10
    static let leadingMargin: CGFloat = 10
    static let trailingMargin: CGFloat = -10
    static let bottomMargin: CGFloat = -10
}

enum ManageType {
    case add
    case edit
    case detail
    
    var leftButtonItem: UIBarButtonItem.SystemItem {
        switch self {
        case .add, .edit:
            return .cancel
        case .detail:
            return .edit
        }
    }
}

class TaskManageViewController: UIViewController {
    let taskStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = .preferredFont(forTextStyle: .title3)
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.3
        textField.layer.shadowOpacity = 0.5
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.shadowOffset = CGSize(width: 0, height: 3)
        textField.layer.masksToBounds = false
        return textField
    }()
    
    let deadlineDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        return datePicker
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = .preferredFont(forTextStyle: .title3)
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 0.3
        textView.layer.shadowOpacity = 0.5
        textView.layer.shadowColor = UIColor.black.cgColor
        textView.layer.shadowOffset = CGSize(width: 0, height: 3)
        textView.layer.masksToBounds = false
        return textView
    }()
    
    var manageType: ManageType
    var taskListViewModel: TaskViewModel
    
    init(manageType: ManageType, taskListViewModel: TaskViewModel) {
        self.manageType = manageType
        self.taskListViewModel = taskListViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("스토리보드 사용하지 않음")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        configureNavigationBar()
        configureLayout()
    }
    
    private func configureLayout() {
        [titleTextField, deadlineDatePicker, descriptionTextView].forEach {
            taskStackView.addArrangedSubview($0)
        }
        
        view.addSubview(taskStackView)
        
        NSLayoutConstraint.activate([
            taskStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Design.topMargin),
            taskStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Design.leadingMargin),
            taskStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Design.trailingMargin),
            taskStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Design.bottomMargin)
        ])
    }
    
    private func saveTask() {
        guard let title = titleTextField.text,
              let description = descriptionTextView.text else {
            return
        }
        
        taskListViewModel.createTask(title: title, description: description, deadline: deadlineDatePicker.date)
    }
     
    private func configureNavigationBar() {
        navigationItem.title = "TODO"
        
        switch manageType {
        case .add, .edit:
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: manageType.leftButtonItem, target: self, action: #selector(didTapCancel))
        case .detail:
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: manageType.leftButtonItem, target: self, action: #selector(didTapEdit))
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDone))
    }
    
    @objc func didTapCancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapEdit() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
    }
    
    @objc func didTapDone() {
        switch manageType {
        case .add, .edit:
            saveTask()
            self.dismiss(animated: true, completion: nil)
        case .detail:
            self.dismiss(animated: true, completion: nil)
        }        
    }
}


