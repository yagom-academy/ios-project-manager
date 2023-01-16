//
//  DetailViewController.swift
//  ProjectManager
//
//  Created by Mangdi on 2023/01/14.
//

import UIKit

class DetailViewController: UIViewController {

    private lazy var navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        let navigationItem = UINavigationItem(title: "TODO")
        switch mode {
        case .add:
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(addTodo))
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissView))
        case .modify:
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissView))
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .done, target: self, action: #selector(editTodo))
        }
        navigationBar.items = [navigationItem]
        navigationBar.barTintColor = UIColor.systemGray6
        return navigationBar
    }()

    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.preferredFont(forTextStyle: .title3)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.7).cgColor
        textField.layer.shadowOpacity = 0.3
        textField.layer.shadowOffset = CGSize(width: 0, height: 3)
        textField.backgroundColor = .white
        textField.attributedPlaceholder = NSAttributedString(
            string: "Title",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray3]
        )
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        return textField
    }()

    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        return picker
    }()

    private let bodyTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.preferredFont(forTextStyle: .title3)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.7).cgColor
        textView.clipsToBounds = false
        textView.layer.shadowOpacity = 0.3
        textView.layer.shadowOffset = CGSize(width: 0, height: 3)
        textView.textColor = UIColor.black
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return textView
    }()

    weak var detailViewDelegate: DetailViewDelegate?
    var todo: TodoModel?
    var mode: DetailViewMode = .add
    var selectedItem: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        bodyTextView.delegate = self

        view.backgroundColor = .white
        view.addSubview(navigationBar)
        view.addSubview(titleTextField)
        view.addSubview(datePicker)
        view.addSubview(bodyTextView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        switch mode {
        case .add:
            break
        case .modify:
            guard let todo = todo,
                  let date = convertStringToDate(dateText: todo.date) else { return }
            titleTextField.text = todo.title
            bodyTextView.text = todo.body
            datePicker.date = date
        }
    }

    override func viewDidLayoutSubviews() {
        configureSubViews()
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureSubViews() {
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            titleTextField.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 4),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            titleTextField.bottomAnchor.constraint(equalTo: datePicker.topAnchor),
            titleTextField.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1),

            datePicker.topAnchor.constraint(equalTo: titleTextField.bottomAnchor),
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            datePicker.bottomAnchor.constraint(equalTo: bodyTextView.topAnchor),

            bodyTextView.topAnchor.constraint(equalTo: datePicker.bottomAnchor),
            bodyTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            bodyTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            bodyTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
        ])
    }

    private func convertDateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy. MM. dd"
        let date = formatter.string(from: datePicker.date)
        return date
    }

    private func convertStringToDate(dateText: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy. MM. dd"
        guard let date = formatter.date(from: dateText) else { return nil }
        return date
    }
}

// MARK: - Objc
extension DetailViewController {
    @objc private func addTodo() {
        guard let title = titleTextField.text,
              let body = bodyTextView.text else { return }
        let date = convertDateToString(date: datePicker.date)
        let todoModel = TodoModel(title: title, body: body, date: date)

        detailViewDelegate?.addTodo(todoModel: todoModel)
        dismiss(animated: true)
    }

    @objc private func dismissView() {
        dismiss(animated: true)
    }

    @objc private func editTodo() {
        guard let title = titleTextField.text,
              let body = bodyTextView.text,
              let selectedItem = selectedItem else { return }
        let date = convertDateToString(date: datePicker.date)
        let todoModel = TodoModel(title: title, body: body, date: date)

        detailViewDelegate?.editTodo(todoModel: todoModel, selectedItem: selectedItem)
    }
}

extension DetailViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let changedText = currentText.replacingCharacters(in: stringRange, with: text)
        return changedText.count <= 1000
    }
}
