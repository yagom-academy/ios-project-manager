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

final class TaskManageViewController: UIViewController {
    // MARK: - Properties

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
        return textView
    }()
        
    var selectedIndex: Int?
    var selectedTask: Task?
    var manageType: ManageType
    var taskListViewModel: TaskViewModel
    
    // MARK: - Life Cycle

    init(manageType: ManageType, taskListViewModel: TaskViewModel) {
        self.manageType = manageType
        self.taskListViewModel = taskListViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience init(manageType: ManageType, taskListViewModel: TaskViewModel, task: Task, selectedIndex: Int) {
        self.init(manageType: manageType, taskListViewModel: taskListViewModel)
        self.selectedTask = task
        self.selectedIndex = selectedIndex
    }
    
    required init?(coder: NSCoder) {
        fatalError("스토리보드 사용하지 않음")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupData(from: selectedTask)
        setupEditingState(from: manageType)
    }
    
    // MARK: - Configure UI

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
    
    private func setupEditingState(from manageType: ManageType) {
        if manageType == .detail {
            titleTextField.isUserInteractionEnabled.toggle()
            deadlineDatePicker.isUserInteractionEnabled.toggle()
            descriptionTextView.isUserInteractionEnabled.toggle()
        }
    }
    
    private func setupData(from task: Task?) {
        guard let task = task else {
            return
        }

        titleTextField.text = task.title
        deadlineDatePicker.date = task.deadline
        descriptionTextView.text = task.description
    }
     
    // MARK: - Configure Edit/Cancel/Add

    private func configureNavigationBar() {
        navigationItem.title = selectedTask?.state.title
        
        switch manageType {
        case .add, .edit:
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: manageType.leftButtonItem, target: self, action: #selector(didTapCancel))
        case .detail:
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: manageType.leftButtonItem, target: self, action: #selector(didTapEdit))
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDone))
    }
    
    private func saveTask() {
        guard let title = titleTextField.text,
              let description = descriptionTextView.text else {
            return
        }
        
        taskListViewModel.createTask(title: title, description: description, deadline: deadlineDatePicker.date)
    }
    
    private func updateTask() {
        guard let title = titleTextField.text,
              let description = descriptionTextView.text,
              let selectedIndex = selectedIndex,
              let selectedTask = selectedTask else {
            return
        }
        
        taskListViewModel.updateRow(at: selectedIndex,
                                    title: title,
                                    description: description,
                                    deadline: deadlineDatePicker.date,
                                    from: selectedTask.state)
    }
    
    private func checkValidInput() -> Bool {
        var invalidItems = [String]()
        if titleTextField.text == "" {
            invalidItems.append("제목")
        }
        
        if descriptionTextView.text == "" {
            invalidItems.append("내용")
        }
        
        if invalidItems.isEmpty {
            return true
        }
        
        presentAlert(title: "\(invalidItems.joined(separator: ", "))을 입력해주세요", message: "")
        return false
    }
    
    private func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(confirmAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func didTapCancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapEdit() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
        setupEditingState(from: manageType)
    }
    
    @objc func didTapDone() {
        guard checkValidInput() else {
            return
        }
        
        switch manageType {
        case .add, .edit:
            saveTask()
        case .detail:
            updateTask()
        }
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITextViewDelegate

extension TaskManageViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if range.location == 1000 {
            presentAlert(title: "입력 초과", message: "1,000 글자 미만으로 입력해주세요")
            return false
        }
        if range.length > 0 {
            return true
        }
        return range.location < 1000
    }
}
