//
//  AddViewController.swift
//  ProjectManager
//
//  Created by Kyo on 2023/01/13.
//

import UIKit

final class UpdateViewController: UIViewController {
    private enum UIConstant {
        static let topValue = 10.0
        static let leadingValue = 10.0
        static let trailingValue = -10.0
        static let bottomValue = -10.0
    }
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Title"
        textField.font = .preferredFont(forTextStyle: .title1)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderColor = UIColor.systemGray5.cgColor
        textView.font = .preferredFont(forTextStyle: .title2)
        textView.layer.borderWidth = 2
        return textView
    }()
    
    private let datePicker = UIDatePicker()
    
    private lazy var textFieldView: UIView = {
        let view = UIView()
        view.addSubview(titleTextField)
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.systemGray5.cgColor
        return view
    }()
    
    private lazy var addStackView = UIStackView(
        views: [textFieldView, datePicker, descriptionTextView],
        axis: .vertical,
        alignment: .fill,
        distribution: .fill,
        spacing: 10
    )
    
    private let viewModel: MainViewModel
    private var process: Process
    
    init(procss: Process, viewModel: MainViewModel) {
        self.process = procss
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupView()
        setupDatePicker()
        setupConstraint()
    }
    
    @objc private func datePickerWheel(_ sender: UIDatePicker) -> Date? {
        return sender.date
    }
    
    @objc private func doneButtonTapped() {
        guard let title = titleTextField.text else { return }
        let date = datePickerWheel(datePicker)
        viewModel.uploadData(title: title, content: descriptionTextView.text, date: date)
        dismiss(animated: true)
    }
    
    @objc private func cancelButtonTapped() {
        
    }
    
    @objc private func editButtonTapped() {
        
    }
}

// MARK: - UI Confuration
extension AddViewController {
    private func setupNavigationBar() {
        title = process.titleValue
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemGray6
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        let cancelButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(cancelButtonTapped)
        )
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneButtonTapped)
        )
        
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = doneButton
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(addStackView)
    }
    
    private func setupDatePicker() {
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerWheel), for: .valueChanged)
    }
    
    private func setupConstraint() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(
                equalTo: textFieldView.topAnchor,
                constant: UIConstant.topValue
            ),
            titleTextField.leadingAnchor.constraint(
                equalTo: textFieldView.leadingAnchor,
                constant: UIConstant.leadingValue
            ),
            titleTextField.trailingAnchor.constraint(
                equalTo: textFieldView.trailingAnchor,
                constant: UIConstant.trailingValue
            ),
            titleTextField.bottomAnchor.constraint(
                equalTo: textFieldView.bottomAnchor,
                constant: UIConstant.bottomValue
            ),
            
            addStackView.topAnchor.constraint(
                equalTo: safeArea.topAnchor,
                constant: UIConstant.topValue
            ),
            addStackView.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor,
                constant: UIConstant.leadingValue
            ),
            addStackView.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor,
                constant: UIConstant.trailingValue
            ),
            addStackView.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor,
                constant: UIConstant.bottomValue
            )
        ])
    }
}
