//
//  TaskDetailViewController.swift
//  ProjectManager
//
//  Created by 천수현 on 2021/07/20.
//

import UIKit

final class TaskDetailViewController: UIViewController {
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

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: nil)

        setUpTitleTextView()
        setUpDatePickerView()
        setUpDescriptionTextView()
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
}
