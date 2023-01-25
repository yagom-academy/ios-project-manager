//
//  AddProjectViewController.swift
//  ProjectManager
//
//  Created by jin on 1/16/23.
//

import UIKit

class AddProjectViewController: UIViewController {

    enum Constant {
        static let datePickerWidth: CGFloat = 400
        static let navigationTitle = "TODO"
        static let titleTextFieldPlaceHolder = "Title"
        static let stackViewSpacing: CGFloat = 10
    }

    // MARK: - Properties
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let titleTextField = {
        let textField = UITextField()
        textField.placeholder = Constant.titleTextFieldPlaceHolder
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let datePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
    }

    // MARK: - UI
    private func configureUI() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(titleTextField)
        stackView.addArrangedSubview(datePicker)
        stackView.addArrangedSubview(descriptionTextView)
        configureNavigationItem()
        configureDatePicker()
        configureContraints()
    }
    
    private func configureNavigationItem() {
        navigationItem.title = Constant.navigationTitle
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissCurrentViewController))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(saveAndDismissCurrentViewController))
    }

    private func configureDatePicker() {
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.locale = .current
        datePicker.timeZone = .current
    }

    private func configureContraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constant.stackViewSpacing),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Constant.stackViewSpacing),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constant.stackViewSpacing),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Constant.stackViewSpacing)
        ])
    }

    // MARK: - Selectors
    @objc private func dismissCurrentViewController() {
        self.dismiss(animated: true)
    }

    @objc private func saveAndDismissCurrentViewController() {
        self.dismissCurrentViewController()
    }
    // MARK: - Helpers
}
