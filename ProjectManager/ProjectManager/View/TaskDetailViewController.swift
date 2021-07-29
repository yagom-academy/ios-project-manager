//
//  TaskDetailViewController.swift
//  ProjectManager
//
//  Created by 천수현 on 2021/07/20.
//

import UIKit

final class TaskDetailViewController: UIViewController {
    enum Mode {
        case add, edit
    }

    private var mode: Mode = .add
    private var status: TaskStatus? = .TODO
    private var indexPath: IndexPath?

    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Title"
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        return textField
    }()

    private let datePickerView: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: Locale.preferredLanguages.first!)
        datePicker.datePickerMode = .date
        return datePicker
    }()

    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.black.cgColor
        return textView
    }()

    init(mode: Mode, status: TaskStatus? = nil, indexPath: IndexPath? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.mode = mode
        self.status = status
        self.indexPath = indexPath
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationItem()
        setUpTitleTextView()
        setUpDatePickerView()
        setUpDescriptionTextView()
        fetchTaskData()
    }

    private func setUpNavigationItem() {
        let leftBarButtonSystemItem: UIBarButtonItem.SystemItem = self.mode == .add ? .cancel : .edit

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(rightBarButtonDidTapped)
        )

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: leftBarButtonSystemItem,
            target: self,
            action: #selector(leftBarButtonDidTapped)
        )
    }

    private func setUpTitleTextView() {
        view.addSubview(titleTextField)
        titleTextField.snp.makeConstraints { textView in
            textView.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            textView.leading.equalTo(view).inset(10)
            textView.trailing.equalTo(view).inset(10)
            textView.height.equalTo(100)
        }
    }

    private func setUpDatePickerView() {
        view.addSubview(datePickerView)
        datePickerView.snp.makeConstraints { picker in
            picker.top.equalTo(titleTextField.snp.bottom).offset(10)
            picker.leading.equalTo(view).inset(10)
            picker.trailing.equalTo(view).inset(10)
        }
    }

    private func setUpDescriptionTextView() {
        view.addSubview(descriptionTextView)
        descriptionTextView.snp.makeConstraints { textView in
            textView.top.equalTo(datePickerView.snp.bottom).offset(10)
            textView.leading.equalTo(view).inset(10)
            textView.trailing.equalTo(view).inset(10)
            textView.bottom.equalTo(view).inset(10)
        }
    }

    private func fetchTaskData() {
        guard let indexPath = indexPath,
              let status = self.status else { return }

        switch status {
        case .TODO:
            titleTextField.text =  TaskManager.shared.toDoTasks[indexPath.row].title
            descriptionTextView.text =  TaskManager.shared.toDoTasks[indexPath.row].body
            datePickerView.date = Date(timeIntervalSince1970: TaskManager.shared.toDoTasks[indexPath.row].date)
        case .DOING:
            titleTextField.text =  TaskManager.shared.doingTasks[indexPath.row].title
            descriptionTextView.text =  TaskManager.shared.doingTasks[indexPath.row].body
            datePickerView.date = Date(timeIntervalSince1970: TaskManager.shared.doingTasks[indexPath.row].date)
        case .DONE:
            titleTextField.text =  TaskManager.shared.doneTasks[indexPath.row].title
            descriptionTextView.text =  TaskManager.shared.doneTasks[indexPath.row].body
            datePickerView.date = Date(timeIntervalSince1970: TaskManager.shared.doneTasks[indexPath.row].date)
        }
    }

    @objc private func leftBarButtonDidTapped() {
        switch self.mode {
        case .add:
            break
        case .edit:
            editTask()
        }

        dismiss(animated: true, completion: nil)
    }

    @objc private func rightBarButtonDidTapped() {
        switch self.mode {
        case .add:
            addTask()
        case .edit:
            editTask()
        }

        dismiss(animated: true, completion: nil)
    }

    private func addTask() {
        TaskManager.shared.createTask(
            title: titleTextField.text!, // 애플 공식문서: This string is @"" by default.
            description: descriptionTextView.text,
            date: datePickerView.date
        )
    }

    private func editTask() {
        guard let indexPath = indexPath,
              let status = self.status else { return }

        TaskManager.shared.editTask(
            indexPath: indexPath,
            title: titleTextField.text!,
            description: descriptionTextView.text,
            date: datePickerView.date,
            status: status
        )
    }
}
