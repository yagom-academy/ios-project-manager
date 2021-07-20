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

    private var status: String? = "toDo"

    private var indexPath: IndexPath?

    private let titleTextView: UITextView = {
        let textView = UITextView()
        textView.text = "textView"
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.black.cgColor
        return textView
    }()

    private let datePickerView: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: Locale.preferredLanguages.first!)
        datePicker.datePickerMode = .date // optional
        return datePicker
    }()

    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.text = "textView"
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.black.cgColor
        return textView
    }()

    init(mode: Mode, status: String? = nil, indexPath: IndexPath? = nil) {
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
    }

    private func setUpNavigationItem() {
        let leftBarButtonSystemItem: UIBarButtonItem.SystemItem = mode == .add ? .cancel : .edit

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(touchUpDoneButton)
        )

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: leftBarButtonSystemItem,
            target: self,
            action: #selector(touchUpCancelButton)
        )
    }

    private func setUpTitleTextView() {
        view.addSubview(titleTextView)
        titleTextView.snp.makeConstraints { textView in
            textView.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            textView.leading.equalTo(view).inset(10)
            textView.trailing.equalTo(view).inset(10)
            textView.height.equalTo(100)
        }
    }

    private func setUpDatePickerView() {
        view.addSubview(datePickerView)
        datePickerView.snp.makeConstraints { picker in
            picker.top.equalTo(titleTextView.snp.bottom).offset(10)
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

    @objc private func touchUpCancelButton() {
        dismiss(animated: true, completion: nil)
    }

    @objc private func touchUpDoneButton() {
        switch mode {
        case .add:
            TaskManager.shared.createTask(
                title: titleTextView.text,
                description: descriptionTextView.text,
                date: datePickerView.date
            )
        case .edit:
            guard let indexPath = indexPath else { return }

            TaskManager.shared.editTask(
                indexPath: indexPath,
                title: titleTextView.text,
                description: descriptionTextView.text,
                date: datePickerView.date,
                status: "toDo"
            )
        }

        dismiss(animated: true, completion: nil)
    }
}
