//
//  MakeTaskView.swift
//  ProjectManager
//
//  Created by 기원우 on 2021/08/04.
//

import UIKit
import SnapKit

class TaskDetailView: UIViewController {
    var delegate: TaskViewControllerDelegate?

    let titleTextfield: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Title"
        textfield.font = UIFont.preferredFont(forTextStyle: .title2)
        textfield.layer.borderColor = UIColor.systemGray3.cgColor
        textfield.layer.borderWidth = 2.0
        textfield.addLeftPadding()
        return textfield
    }()

    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        return datePicker

    }()

    let contentTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderColor = UIColor.systemGray3.cgColor
        textView.layer.borderWidth = 2.0
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setNavigationBar()

        self.view.addSubview(titleTextfield)
        self.view.addSubview(datePicker)
        self.view.addSubview(contentTextView)

        titleTextfield.snp.makeConstraints { textField in
            textField.top.equalTo(view.safeAreaLayoutGuide).inset(5)
            textField.leading.trailing.equalTo(view).inset(10)
            textField.height.equalTo(50)
        }

        datePicker.snp.makeConstraints { datePicker in
            datePicker.top.equalTo(titleTextfield.snp.bottom).offset(10)
            datePicker.centerX.equalTo(view)
        }

        contentTextView.snp.makeConstraints { textView in
            textView.top.equalTo(datePicker.snp.bottom).offset(10)
            textView.leading.trailing.equalTo(view).inset(10)
            textView.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
    }

    private func setNavigationBar() {
        navigationItem.title = "TODO"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                           target: self,
                                                           action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                            target: self,
                                                            action: #selector(didTapDoneButton))
    }

    @objc func didTapDoneButton() {
        let task = Task(title: titleTextfield.text!, context: contentTextView.text, deadline: datePicker.date)

        delegate?.createTodoTask(task: task)
        delegate?.countheadViewNumber()

        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITextField func
extension UITextField {
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}
