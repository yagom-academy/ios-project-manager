//
//  DetailViewController.swift
//  ProjectManager
//
//  Created by GUNDY on 2023/01/15.
//

import UIKit

final class DetailViewController: UIViewController {
    
    typealias Text = Constant.Text
    typealias Style = Constant.Style
    
    var viewModel: DetailViewModel?
    var delegate: DetailProjectDelegate?
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()
    
    private let  titleTextField: DetailTextField = {
        let textFiled = DetailTextField()
        textFiled.placeholder = Text.titlePlaceHolder
        
        return textFiled
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: Locale.preferredLanguages[0])
        
        return datePicker
    }()
    
    private let descriptionTextView: DetailTextView = {
        let textView = DetailTextView()
        textView.keyboardDismissMode = .onDrag
        
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
                                           constant: Style.detailStackViewTopAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                               constant: Style.detailStackViewLeadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                              constant: Style.detailStackViewBottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                constant: Style.detailStackViewTrailingAnchor)
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
        
        if viewModel?.isEditable == false {
            titleTextField.isEnabled = false
            datePicker.isEnabled = false
            descriptionTextView.isEditable = false
        }
    }
    
    private func configureHandler() {
        viewModel?.bindEditable { isEditable in
            if isEditable == true {
                self.navigationItem.leftBarButtonItem = self.makeLeftButton()
                self.navigationItem.rightBarButtonItem = self.makeDoneButton()
                self.titleTextField.isEnabled = true
                self.datePicker.isEnabled = true
                self.descriptionTextView.isEditable = true
            }
        }
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
            action = UIAction { _ in
                self.saveProjectIfValid() {
                    self.dismiss(animated: true)
                }
            }
        case false:
            action = UIAction { _ in
                self.dismiss(animated: true)
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
        let action = UIAction { _ in
            self.dismiss(animated: true)
        }

        return action
    }
    
    private func tappedEditButtonAction() -> UIAction {
        let action = UIAction { _ in
            self.viewModel?.changeEditable(state: true)
        }

        return action
    }
    
    private func saveProjectIfValid(handler: () -> ()) {
        guard viewModel?.validateDeadline(date: datePicker.date) == true else {
            showAlert(message: Text.invalidDeadlineMessage)
            return
        }
        
        guard let project = viewModel?.makeProject(title: titleTextField.text ?? "",
                                             description: descriptionTextView.text,
                                                   deadline: datePicker.date) else {
            preconditionFailure("viewModel이 올바르지 않습니다.")
        }
        
        delegate?.detailProject(willSave: project)
        handler()
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

extension DetailViewController: DetailProject { }
