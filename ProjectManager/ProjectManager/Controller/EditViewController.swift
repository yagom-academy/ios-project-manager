//
//  EditViewController.swift
//  ProjectManager
//
//  Created by 고은 on 2022/03/03.
//

import UIKit

class EditViewController: UIViewController, UIAdaptivePresentationControllerDelegate {

// MARK: - Properties

    private var todo: Todo?
    private var beingEditedTodoTask: TodoTasks?
    weak var dataProvider: DataProvider?
    weak var mainViewDelegate: EditEventAvailable?

// MARK: - View Components

    private lazy var cancelButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = EditControllerScript.cancel
        button.target = self
        button.action = #selector(cancelButtonDidTap)

        return button
    }()

    private lazy var doneButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = EditControllerScript.done
        button.target = self
        button.action = #selector(doneButtonDidTap)

        return button
    }()

    private let editView: EditView = {
        let view = EditView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

// MARK: - Override Method(s)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpController()
        self.view.backgroundColor = EditControllerColor.background
    }

// MARK: - SetUp Controller

    private func setUpController() {
        self.configureView()
        self.configureNavigationBar()
        self.setUpDelegate()
        self.setUpTextField()
        self.setUpTextView()
        self.setUpDefaultStatus()
    }

    private func setUpTextField() {
        self.editView.textField.addTarget(
            self, action: #selector(textFieldDidChange(_:)), for: .editingChanged
        )
    }

    private func setUpTextView() {
        self.editView.textView.text =  EditControllerScript.textViewPlaceHolder
        self.editView.textView.textColor = EditControllerColor.placeHolderTextColor
    }

    private func setUpDelegate() {
        self.editView.textView.delegate = self
        self.navigationController?.presentationController?.delegate = self
    }

    private func setUpDefaultStatus() {
        self.isModalInPresentation = false
        self.doneButton.isEnabled = false
        self.doneButton.customView?.alpha = 0.5
    }

// MARK: - SetUp Default Value

    func setUpDefaultValue(todo: Todo, at task: TodoTasks) {
        self.todo = todo
        self.beingEditedTodoTask = task
        self.applyDefaultValue()
    }

    func resetToDefaultValue() {
        self.editView.textField.text = nil
        self.editView.datePicker.date = Date()
        self.editView.textView.text = EditControllerScript.textViewPlaceHolder
        self.editView.textView.textColor = EditControllerColor.placeHolderTextColor
    }

    private func applyDefaultValue() {
        guard let date = self.todo?.deadline?.date else {
            return
        }

        self.editView.textField.text = self.todo?.title
        self.editView.datePicker.date = date
        self.editView.textView.text = self.todo?.content
    }

// MARK: - Configure View

    private func configureView() {
        self.view.addSubview(self.editView)
        NSLayoutConstraint.activate([
            self.editView.topAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.topAnchor
            ),
            self.editView.bottomAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.bottomAnchor
            ),
            self.editView.leadingAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.leadingAnchor
            ),
            self.editView.trailingAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.trailingAnchor
            )
        ])
    }

    private func configureNavigationBar() {
        self.title = EditControllerScript.title
        self.navigationItem.leftBarButtonItem = self.cancelButton
        self.navigationItem.rightBarButtonItem = self.doneButton
    }

// MARK: - Button Actions

    @objc
    private func cancelButtonDidTap() {
        self.mainViewDelegate?.editViewControllerDidCancel(self)
    }

    @objc
    private func doneButtonDidTap() {
        if self.editView.textView.text == EditControllerScript.textViewPlaceHolder {
            self.editView.textView.text = EditControllerScript.emptyText
        }

        let todo = self.convertToTodo()

        self.branchWithOrWithoutDefaultValue(newTodo: todo)
        self.mainViewDelegate?.editViewControllerDidFinish(self)
    }

    @objc
    private func textFieldDidChange(_ textField: UITextField) {
        guard let textFieldIsEmpty = self.editView.textField.text?.isEmpty else {
            return
        }

        if textFieldIsEmpty {
            self.doneButton.isEnabled = false
            self.isModalInPresentation = false
            self.doneButton.customView?.alpha = 0.5
        } else {
            self.doneButton.isEnabled = true
            self.isModalInPresentation = true
            self.doneButton.customView?.alpha = 1.0
        }
    }

// MARK: - Communication Processing Method

    private func convertToTodo() -> Todo {
        let todo = Todo(
            title: self.editView.textField.text ?? EditControllerScript.untitled,
            content: self.editView.textView.text,
            deadline: self.editView.datePicker.date.double,
            uuid: self.todo?.uuid ?? UUID()
        )

        return todo
    }

    private func branchWithOrWithoutDefaultValue(newTodo: Todo) {
        if let task = self.beingEditedTodoTask,
           let originalTodo = self.todo {
            self.dataProvider?.update(todo: newTodo, at: task, originalTodo: originalTodo)
            self.todo = nil
        } else {
            self.dataProvider?.add(todo: newTodo, at: .todo)
        }
    }
}

// MARK: - TextView Delegate

extension EditViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == EditControllerColor.placeHolderTextColor {
            textView.text = nil
            textView.textColor = EditControllerColor.defaultTextColor
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty || textView.text == "" {
            textView.text = EditControllerScript.textViewPlaceHolder
            textView.textColor = EditControllerColor.placeHolderTextColor
        }
    }

    func textView(
        _ textView: UITextView,
        shouldChangeTextIn range: NSRange,
        replacementText text: String
    ) -> Bool {
        guard let textViewText = textView.text else {
            return true
        }

        let newLength = textViewText.count + text.count - range.length

        return newLength <= EditControllerConstraint.maximumTextLength
    }
}

// MARK: - Magic Numbers
extension EditViewController {

    private enum EditControllerScript {

        static let title = "TODO"
        static let cancel = "Cancel"
        static let done = "Done"
        static let textViewPlaceHolder = "1000자 이내로 입력해주세요"
        static let untitled = "무제"
        static let emptyText = ""
    }

    private enum EditControllerConstraint {

        static let maximumTextLength = 1000
    }

    private enum EditControllerColor {

        static let background: UIColor = .white
        static let placeHolderTextColor: UIColor = .lightGray
        static let defaultTextColor: UIColor = .black
    }
}
