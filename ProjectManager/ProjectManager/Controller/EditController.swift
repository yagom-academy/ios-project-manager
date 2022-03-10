//
//  EditViewController.swift
//  ProjectManager
//
//  Created by 고은 on 2022/03/03.
//

import UIKit

class EditController: UIViewController, UIAdaptivePresentationControllerDelegate {

// MARK: - Properties

    var hasChanges: Bool {
        return self.editView.textField.text != nil
    }
    var beingEditedTodoUUID: UUID?
    var beingEditedTodoSection: TodoSection?
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

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.doneButton.isEnabled = hasChanges
        self.isModalInPresentation = hasChanges
    }

// MARK: - SetUp Controller

    private func setUpController() {
        self.configureView()
        self.configureNavigationBar()
        self.setUpDelegate()
        self.setUpTextView()
    }

    private func setUpTextView() {
        self.editView.textView.text =  EditControllerScript.textViewPlaceHolder
        self.editView.textView.textColor = EditControllerColor.placeHolderTextColor
    }

    private func setUpDelegate() {
        self.editView.textView.delegate = self
        self.navigationController?.presentationController?.delegate = self
    }

// MARK: - SetUp Default Value

    func setUpDefaultValue(todo: Todo) {
        guard let date = todo.deadline?.date else {
            return
        }

        self.editView.textField.text = todo.title
        self.editView.datePicker.date = date
        self.editView.textView.text = todo.content
        self.beingEditedTodoSection = todo.section
        self.beingEditedTodoUUID = todo.uuid
    }

    func resetToDefaultValue() {
        self.editView.textField.text = nil
        self.editView.datePicker.date = Date()
        self.editView.textView.text = EditControllerScript.textViewPlaceHolder
        self.editView.textView.textColor = EditControllerColor.placeHolderTextColor
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
        guard let dataProvider = self.dataProvider else {
            return
        }

        let todo = Todo(
            title: self.editView.textField.text ?? EditControllerScript.untitled,
            content: self.editView.textView.text,
            deadline: self.editView.datePicker.date.double,
            section: self.beingEditedTodoSection ?? .todo,
            uuid: self.beingEditedTodoUUID ?? UUID()
        )

        if self.beingEditedTodoUUID != nil, self.beingEditedTodoSection != nil {
            dataProvider.edit(todo: todo, in: todo.section)
            self.beingEditedTodoUUID = nil
            self.beingEditedTodoSection = nil
        } else {
            dataProvider.update(todo: todo)
        }

        self.mainViewDelegate?.editViewControllerDidFinish(self)
    }
}

// MARK: - TextView Delegate

extension EditController: UITextViewDelegate {
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

private enum EditControllerScript {

    static let title = "TODO"
    static let cancel = "Cancel"
    static let done = "Done"
    static let textViewPlaceHolder = "1000자 이내로 입력해주세요"
    static let untitled = "무제"
}

private enum EditControllerConstraint {

    static let maximumTextLength = 1000
}

private enum EditControllerColor {

    static let background: UIColor = .white
    static let placeHolderTextColor: UIColor = .lightGray
    static let defaultTextColor: UIColor = .black
}
