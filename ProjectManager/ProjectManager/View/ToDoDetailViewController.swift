//
//  ToDoDetailViewController.swift
//  ProjectManager
//
//  Created by Moon on 2023/09/30.
//

import UIKit

final class ToDoDetailViewController: UIViewController {
    // MARK: - Title Bar property
    private let leftButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.titleLabel?.font = .preferredFont(forTextStyle: .title3)
        
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Category.todo.rawValue
        label.font = .preferredFont(for: .title3, weight: .bold)
        label.adjustsFontForContentSizeCategory = true
        
        return label
    }()
    
    private lazy var rightButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.titleLabel?.font = .preferredFont(forTextStyle: .title3)
        button.addAction(dismissAction(), for: .touchUpInside)
        
        return button
    }()
    
    private let titleBarStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.backgroundColor = .systemGray6
        stackView.layoutMargins = .init(top: 10, left: 20, bottom: 10, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        return stackView
    }()
    
    // MARK: - Content property
    private let titleTextField: InsetTextField = {
        let textField = InsetTextField()
        textField.placeholder = "Title"
        textField.font = .preferredFont(forTextStyle: .title3)
        textField.backgroundColor = .systemBackground
        textField.adjustsFontForContentSizeCategory = true
        
        return textField
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        
        return datePicker
    }()
    
    private let bodyTextView: UITextView = {
        let textView = UITextView()
        textView.font = .preferredFont(forTextStyle: .title3)
        textView.adjustsFontForContentSizeCategory = true
        
        return textView
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.layoutMargins = .init(top: 10, left: 20, bottom: 30, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        return stackView
    }()
    
    private let titleShadowView: UIView = {
        let view = UIView()
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: .zero, height: 3)
        view.layer.shadowRadius = 3
        
        return view
    }()
    
    private let bodyShadowView: UIView = {
        let view = UIView()
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: .zero, height: 3)
        view.layer.shadowRadius = 3
        
        return view
    }()
    
    init(isNew: Bool) {
        super.init(nibName: nil, bundle: nil)
        
        configureUI()
        setUpDelegates()
        setUpLeftButton(isNew: isNew)
        setUpEditableContent(isNew: isNew)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpDelegates() {
        bodyTextView.delegate = self
    }
    
    private func setUpLeftButton(isNew: Bool) {
        if isNew {
            leftButton.setTitle("Cancel", for: .normal)
            leftButton.addAction(dismissAction(), for: .touchUpInside)
        } else {
            leftButton.setTitle("Edit", for: .normal)
            leftButton.addAction(enableEditContentAction(), for: .touchUpInside)
        }
    }
    
    private func dismissAction() -> UIAction {
        return UIAction { _ in
            self.dismiss(animated: true)
        }
    }
    
    private func enableEditContentAction() -> UIAction {
        return UIAction { [weak self] _ in
            [self?.titleTextField, self?.datePicker, self?.bodyTextView].forEach {
                $0?.isUserInteractionEnabled = true
                $0?.backgroundColor = .systemBackground
            }
        }
    }
    
    private func setUpEditableContent(isNew: Bool) {
        if isNew == false {
            [titleTextField, datePicker, bodyTextView].forEach {
                $0.isUserInteractionEnabled = false
                $0.backgroundColor = .systemGray6
            }
        }
    }
}

// MARK: - Configure UI
extension ToDoDetailViewController {
    private func configureUI() {
        setUpView()
        addSubviews()
        setUpConstraints()
    }
    
    private func setUpView() {
        view.backgroundColor = .systemBackground
    }
    
    private func addSubviews() {
        [leftButton, titleLabel, rightButton].forEach {
            titleBarStackView.addArrangedSubview($0)
        }
        
        titleShadowView.addSubview(titleTextField)
        bodyShadowView.addSubview(bodyTextView)
        
        [titleShadowView, datePicker, bodyShadowView].forEach {
            contentStackView.addArrangedSubview($0)
        }
        
        view.addSubview(titleBarStackView)
        view.addSubview(contentStackView)
    }
    
    private func setUpConstraints() {
        setUpTitleBarStackViewConstraints()
        setUpTitleTextFieldConstraints()
        setUpBodyTextViewConstraints()
        setUpContentStackViewConstraints()
    }
    
    private func setUpTitleBarStackViewConstraints() {
        titleBarStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleBarStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            titleBarStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            titleBarStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    private func setUpTitleTextFieldConstraints() {
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleTextField.leadingAnchor.constraint(equalTo: titleShadowView.leadingAnchor),
            titleTextField.trailingAnchor.constraint(equalTo: titleShadowView.trailingAnchor),
            titleTextField.topAnchor.constraint(equalTo: titleShadowView.topAnchor),
            titleTextField.bottomAnchor.constraint(equalTo: titleShadowView.bottomAnchor)
        ])
    }
    
    private func setUpBodyTextViewConstraints() {
        bodyTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bodyTextView.leadingAnchor.constraint(equalTo: bodyShadowView.leadingAnchor),
            bodyTextView.trailingAnchor.constraint(equalTo: bodyShadowView.trailingAnchor),
            bodyTextView.topAnchor.constraint(equalTo: bodyShadowView.topAnchor),
            bodyTextView.bottomAnchor.constraint(equalTo: bodyShadowView.bottomAnchor)
        ])
    }
    
    private func setUpContentStackViewConstraints() {
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            contentStackView.topAnchor.constraint(equalTo: titleBarStackView.bottomAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - UITextViewDelegate
extension ToDoDetailViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let originalText = textView.text else {
            return true
        }
        
        let newLength = originalText.count + text.count - range.length
        
        return newLength <= 1000
    }
}
