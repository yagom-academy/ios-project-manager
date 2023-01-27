//
//  DetailViewController.swift
//  ProjectManager
//
//  Created by GUNDY on 2023/01/15.
//

import UIKit

final class DetailViewController: UIViewController {
    
    var viewModel: DetailViewModel?
    weak var delegate: DetailProjectDelegate?
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()
    
    private let titleTextField: UITextField = {
        let textFiled = UITextField()
        textFiled.placeholder = Text.titlePlaceHolder
        textFiled.setShadow()
        
        return textFiled
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: Locale.preferredLanguages[0])
        
        return datePicker
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.keyboardDismissMode = .onDrag
        textView.layer.borderColor = UIColor.red.cgColor
        textView.setShadow()
        
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUIComponent()
        configureHandler()
    }
    
    private func configureUIComponent() {
        view.backgroundColor = .systemBackground
        configureNavigationBar()
        configureViewHierarchy()
        configureLayoutConstraint()
        configureInitialValue()
    }

    private func configureNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .systemGray6
        navigationItem.title = viewModel?.fetchNavigationTitle()
        navigationItem.leftBarButtonItem = makeLeftButton()
        navigationItem.rightBarButtonItem = makeDoneButton()
    }

    private func configureViewHierarchy() {
        [titleTextField, datePicker, descriptionTextView].forEach {
            stackView.addArrangedSubview($0)
        }
        view.addSubview(stackView)
    }

    private func configureLayoutConstraint() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                           constant: 4),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                               constant: 12),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                              constant: -20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                constant: -12)
        ])
    }
    
    private func configureInitialValue() {
        let values = viewModel?.fetchValues()
        guard let date = values?.deadline else {
            return
        }
        
        titleTextField.text = values?.title
        datePicker.date = date
        descriptionTextView.text = values?.description
        descriptionTextView.delegate = self
        configureEditable()
    }
    
    private func configureHandler() {
        viewModel?.bindEditable { [weak self] isEditable in
            if isEditable == true {
                self?.navigationItem.leftBarButtonItem = self?.makeLeftButton()
                self?.navigationItem.rightBarButtonItem = self?.makeDoneButton()
            }
            self?.configureEditable()
        }
        
        viewModel?.bindValidText { [weak self] isValid in
            self?.descriptionTextView.layer.borderWidth = isValid ? .zero : 2
        }
    }
    
    private func configureEditable() {
        titleTextField.isEnabled = viewModel?.isEditable ?? false
        datePicker.isEnabled = viewModel?.isEditable ?? false
        descriptionTextView.isEditable = viewModel?.isEditable ?? false
    }
    
    private func makeDoneButton() -> UIBarButtonItem {
        let button = UIBarButtonItem(systemItem: .done,
                                     primaryAction: tappedDoneButtonAction())

        return button
    }
    
    private func tappedDoneButtonAction() -> UIAction {
        let action: UIAction
        switch viewModel?.isEditable == true  {
        case true:
            action = UIAction { [weak self] _ in
                self?.saveProjectIfValid()
            }
        case false:
            action = UIAction { [weak self] _ in
                self?.dismiss(animated: true)
            }
        }

        return action
    }
    
    private func makeLeftButton() -> UIBarButtonItem {
        let button: UIBarButtonItem
        switch viewModel?.isEditable == true {
        case true:
            button = UIBarButtonItem(systemItem: .cancel,
                                     primaryAction: tappedCancelButtonAction())
        case false:
            button = UIBarButtonItem(systemItem: .edit,
                                     primaryAction: tappedEditButtonAction())
        }
        
        return button
    }
    
    private func tappedCancelButtonAction() -> UIAction {
        let action = UIAction { [weak self] _ in
            self?.dismiss(animated: true)
        }

        return action
    }
    
    private func tappedEditButtonAction() -> UIAction {
        let action = UIAction { [weak self] _ in
            self?.viewModel?.changeEditable(state: true)
        }

        return action
    }
    
    private func saveProjectIfValid() {
        guard viewModel?.validateDeadline(date: datePicker.date) == true else {
            showAlert(message: Text.invalidDeadlineMessage)
            return
        }
        
        guard viewModel?.isValidText == true else {
            showAlert(message: Text.invalidDescriptionMessage)
            return
        }
        
        delegate?.detailProject(willSave: (title: titleTextField.text ?? "",
                                           description: descriptionTextView.text ?? "",
                                           deadline: datePicker.date,
                                           identifier: viewModel?.fetchIdentifier()))
        dismiss(animated: true)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: nil,
                                      message: message,
                                      preferredStyle: .alert)
        let doneAction = UIAlertAction(title: Text.doneButton,
                                       style: .default)
        
        alert.addAction(doneAction)
        present(alert, animated: true, completion: nil)
    }
}

extension DetailViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        viewModel?.validateDescription(text: textView.text)
    }
}

extension DetailViewController: DetailProject { }

extension DetailViewController {
    
    enum Text {
        
        static let doneButton: String = "Done"
        static let titlePlaceHolder: String = "Title"
        static let invalidDeadlineMessage: String = "기한은 과거일 수 없습니다."
        static let invalidDescriptionMessage: String = "본문은 \(Constant.Number.descriptionLimit)자를 넘을 수 없습니다."
    }
}
