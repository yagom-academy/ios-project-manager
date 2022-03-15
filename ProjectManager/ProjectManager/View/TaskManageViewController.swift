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

protocol TaskManageDelegate: AnyObject {
    func create(title: String, description: String, deadline: Date)
    func update(at index: Int, title: String, description: String, deadline: Date, from state: TaskState)
}

final class TaskManageViewController: UIViewController {
    // MARK: - Properties

    private let taskStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let titleTextField: UITextField = {
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
    
    private let deadlineDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        return datePicker
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = .preferredFont(forTextStyle: .title3)
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 0.3
        return textView
    }()

    private let taskManageViewModel: TaskManageViewModel
    private weak var delegate: TaskManageDelegate?
    
    // MARK: - Life Cycle

    init(taskManageViewModel: TaskManageViewModel, delegate: TaskManageDelegate) {
        self.taskManageViewModel = taskManageViewModel
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("스토리보드 사용하지 않음")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTaskManageViewModel()
        configureUI()
        setupData(from: taskManageViewModel.selectedTask)
        setupEditingState(from: taskManageViewModel.manageType)
    }
    
    // MARK: - Configure TaskManageViewModel
    
    private func configTaskManageViewModel() {
        taskManageViewModel.dismiss = { [weak self] manageType in
            switch manageType {
            case .add:
                self?.createTask()
            case .edit, .detail:
                self?.updateTask()
            }
            
            self?.dismiss(animated: true, completion: nil)
        }
        
        taskManageViewModel.changeManageTypeToEdit = { [weak self] manageType in
            guard let self = self else {
                return
            }

            self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.didTapCancel))
            self.setupEditingState(from: manageType)
        }
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
        if manageType == .edit {
            titleTextField.isUserInteractionEnabled = true
            deadlineDatePicker.isUserInteractionEnabled = true
            descriptionTextView.isUserInteractionEnabled = true
        } else if manageType == .detail {
            titleTextField.isUserInteractionEnabled = false
            deadlineDatePicker.isUserInteractionEnabled = false
            descriptionTextView.isUserInteractionEnabled = false
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
        navigationItem.title = taskManageViewModel.selectedTask?.state.title
        
        switch taskManageViewModel.manageType {
        case .add, .edit:
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: taskManageViewModel.manageType.leftButtonItem, target: self, action: #selector(didTapCancel))
        case .detail:
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: taskManageViewModel.manageType.leftButtonItem, target: self, action: #selector(didTapEdit))
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDone))
    }
    
    private func createTask() {
        guard let title = titleTextField.text,
              let description = descriptionTextView.text else {
            return
        }
        
        delegate?.create(title: title, description: description, deadline: deadlineDatePicker.date)
    }
    
    private func updateTask() {
        guard let title = titleTextField.text,
              let description = descriptionTextView.text,
              let selectedIndex = taskManageViewModel.selectedIndex,
              let selectedTask = taskManageViewModel.selectedTask else {
            return
        }
        
        delegate?.update(at: selectedIndex,
                         title: title,
                         description: description,
                         deadline: deadlineDatePicker.date,
                         from: selectedTask.state)
    }
    
    private func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(confirmAction)
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func didTapCancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapEdit() {
        taskManageViewModel.changeToEditState()
    }
    
    @objc private func didTapDone() {
        let title = titleTextField.text
        let description = descriptionTextView.text
        let (invalidItems, isValid) = taskManageViewModel.checkValidInput(title: title, description: description)
        
        if !isValid {
            presentAlert(title: invalidItems, message: "")
            return
        }
        
        taskManageViewModel.didTapDoneButton()
    }
}

// MARK: - UITextViewDelegate

extension TaskManageViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let isValidText = taskManageViewModel.checkValidTextLength(with: range, length: 1000)
        if !isValidText {
            presentAlert(title: "입력 초과", message: "1,000 글자 미만으로 입력해주세요")
        }
        
        return isValidText
    }
}
