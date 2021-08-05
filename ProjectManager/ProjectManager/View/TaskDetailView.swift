//
//  MakeTaskView.swift
//  ProjectManager
//
//  Created by 기원우 on 2021/08/04.
//

import UIKit
import SnapKit

final class TaskDetailView: UIViewController {
    enum Mode {
        case add
        case edit
    }

    private var delegate: TaskViewControllerDelegate?
    private var mode: Mode = .add
    private var index: Int?
    private var classification: String? = Classification.todo.name

    private let titleTextfield: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Title"
        textfield.font = UIFont.preferredFont(forTextStyle: .title2)
        textfield.layer.borderColor = UIColor.systemGray3.cgColor
        textfield.layer.borderWidth = 2.0
        textfield.addLeftPadding()
        return textfield
    }()

    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        return datePicker

    }()

    private let contentTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.layer.borderColor = UIColor.systemGray3.cgColor
        textView.layer.borderWidth = 2.0
        return textView
    }()

    init(delegate: TaskViewControllerDelegate, mode: Mode, index: Int?, classification: String?) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
        self.mode = mode
        self.index = index
        self.classification = classification
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

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
        let rightBarButtonSystemItem: UIBarButtonItem.SystemItem = self.mode == .add ? .done : .edit
        navigationItem.title = "TODO"

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                           target: self,
                                                           action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: rightBarButtonSystemItem,
                                                            target: self,
                                                            action: #selector(didTapRightButton))
    }

    func setTextAndDate(task: Task) {
        titleTextfield.text = task.title
        contentTextView.text = task.context
        datePicker.date = task.deadline
    }

    @objc func didTapRightButton() {
        guard let classification = self.classification,
              let index = self.index else { return }
        let task = Task(title: titleTextfield.text!,
                        context: contentTextView.text,
                        deadline: datePicker.date,
                        classification: classification)

        if mode == .add {
            delegate?.createTodoTask(task: task, index: index)
            delegate?.countHeadViewNumber()
        } else {
            guard let index = self.index else { return }
            delegate?.updateTask(task: task, index: index)
        }

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
