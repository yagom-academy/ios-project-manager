//
//  TaskFormViewController.swift
//  ProjectManager
//
//  Created by steven on 7/23/21.
//

import UIKit

enum FormType {
    case edit
    case add
}

class TaskFormViewController: UIViewController {
    weak var delegate: TaskFormViewControllerDelegate?
    var selectedTask: Task?
    var type: FormType = .edit {
        didSet {
            configureLeftBarButtonItem(type: type)
        }
    }
    
    init(type: FormType) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
        self.configureLeftBarButtonItem(type: type)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    // TODO: 마진 추가
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
    // TODO: 마진 추가
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
        self.view.backgroundColor = .systemBackground
        view.addSubview(stackView)
        configureConstraints()
        navigationItem.title = State.todo.description.uppercased()
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

// MARK: ViewController가 호출하는 함수
extension TaskFormViewController {
    func configureViews(_ task: Task) {
        selectedTask = task
        titleTextField.text = task.title
        contentTextView.text = task.content
        datePicker.date = DateUtil.parseDate(task.deadLine)
        navigationItem.title = task.state.description
    }
}

// MARK: Navigation Bar 버튼 초기화
extension TaskFormViewController {
    private func configureLeftBarButtonItem(type: FormType) {
        switch type {
        case .edit:
            self.view.isUserInteractionEnabled = false
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit",
                                                               style: .plain,
                                                               target: self,
                                                               action: #selector(clinkEditButton))
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector (clickEditDoneButton))
        case .add:
            self.view.isUserInteractionEnabled = true
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                               style: .plain,
                                                               target: self,
                                                               action: #selector(clickCancelButton))
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(clickAddDoneButton))
        }
    }
}

// MARK: Navigation Bar 버튼들 selector 함수들
extension TaskFormViewController {
    @objc private func clinkEditButton() {
        self.view.isUserInteractionEnabled = true
        // TODO: 키보드 입력 후 datepicker 조정시 키보드가 내려가도록 설정
        self.titleTextField.becomeFirstResponder()
    }
    
    @objc private func clickCancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func clickAddDoneButton() {
        let dateText = DateUtil.formatDate(datePicker.date)
        guard let title = titleTextField.text, let content = contentTextView.text else { return }
        if !checkTitleContentIsEmpty() {
            delegate?.addNewTask(Task(title: title, content: content, deadLine: dateText, state: .todo))
            self.dismiss(animated: true, completion: nil)
        } else {
            presentAlertForCompleteTask()
        }
    }
    
    @objc private func clickEditDoneButton() {
        guard let title = titleTextField.text, let content = contentTextView.text else { return }
        guard let selectedTask = selectedTask else { return }
        if !checkTitleContentIsEmpty() {
            selectedTask.title = title
            selectedTask.content = content
            selectedTask.deadLine = DateUtil.formatDate(datePicker.date)
            delegate?.updateEditedCell(state: selectedTask.state)
            self.dismiss(animated: true, completion: nil)
        } else {
            presentAlertForCompleteTask()
        }
    }
    
    private func checkTitleContentIsEmpty() -> Bool {
        if let title = titleTextField.text, !title.isEmpty, let content = contentTextView.text, !content.isEmpty {
            return false
        }
        return true
    }
    
    private func presentAlertForCompleteTask() {
        let alert = UIAlertController(title: "제목과 내용이 비어있습니다", message: "제목과 내용을 모두 채워주세요", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
}

protocol TaskFormViewControllerDelegate: NSObject {
    func updateEditedCell(state: State)
    func addNewTask(_ task: Task)
}
