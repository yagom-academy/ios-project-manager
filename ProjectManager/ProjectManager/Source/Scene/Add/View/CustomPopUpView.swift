//
//  CustomPopUpView.swift
//  ProjectManager
//
//  Created by Dragon on 2023/01/15.
//

import UIKit

final class CustomPopUpView: UIView {
    
    // MARK: Internal Properties
    
    let topLeftButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.blue, for: .normal)
        return button
    }()
    let topRightButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.blue, for: .normal)
        return button
    }()
    
    // MARK: Private Properties
    
    private let popUpView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    private let topBarView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.masksToBounds = true
        return view
    }()
    private let topBarStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .systemGray6
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    private let stateLabel: UILabel = {
        let label = UILabel()
        label.text = MainNameSpace.todoAllUpper
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .headline, compatibleWith: .none)
        return label
    }()
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .white
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setContentHuggingPriority(.defaultHigh, for: .vertical)
        textField.backgroundColor = .white
        textField.font = .preferredFont(forTextStyle: .title3, compatibleWith: .none)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.shadowOffset = CGSize(width: 0, height: 4)
        textField.layer.shadowRadius = 5
        textField.layer.shadowOpacity = 0.3
        return textField
    }()
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: MainNameSpace.defaultDatePickerLocale)
        datePicker.timeZone = .autoupdatingCurrent
        return datePicker
    }()
    private let bodyTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.setContentHuggingPriority(.defaultLow, for: .vertical)
        textView.backgroundColor = .white
        
        textView.font = .preferredFont(forTextStyle: .title3, compatibleWith: .none)
        textView.textContainerInset = UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
        textView.clipsToBounds = false
        textView.layer.shadowColor = UIColor.black.cgColor
        textView.layer.shadowOffset = CGSize(width: 0, height: 4)
        textView.layer.shadowRadius = 5
        textView.layer.shadowOpacity = 0.3
        return textView
    }()
    
    // MARK: Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpTopBarStackView()
        setUpContentStackView()
        configureLayout()
        configureTextDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Internal Methods
    
    func saveProjectData() -> ProjectData? {
        checkTextFieldDefaultValue()
        
        if let title = titleTextField.text,
           let body = bodyTextView.text {
            if title.isEmpty && body.isEmpty {
                return nil
            }
            
            let projectData: ProjectData = ProjectData(
                title: title,
                body: body,
                deadline: datePicker.date.timeIntervalSince1970
            )
            
            return projectData
        }
        
        return nil
    }
    
    func showProjectData(with projectData: ProjectData) {
        titleTextField.text = projectData.title
        bodyTextView.text = projectData.body
    }
    
    func checkDataAccess(mode: DataManagementMode) {
        switch mode {
        case .create:
            configureText()
            configureUserInteraction(enable: true)
        case .edit:
            configureUserInteraction(enable: true)
        case .read:
            configureUserInteraction(enable: false)
        }
    }
    
    func configureTopButtonText(left: String? = nil, right: String? = nil) {
        if let leftButtonText = left {
            topLeftButton.setTitle(leftButtonText, for: .normal)
        }
        if let rightButtonText = right {
            topRightButton.setTitle(rightButtonText, for: .normal)
        }
    }
    
    // MARK: Private Methods
    
    private func checkTextFieldDefaultValue() {
        if var title = titleTextField.text,
           var body = bodyTextView.text {
            if title == NameSpace.defaultTitleLabel
                || title == NameSpace.emptyTitleLabel
                || title.isEmpty {
                title = NameSpace.emptyTitleLabel
            }
            if body == NameSpace.defaultBodyLabel
                || body == NameSpace.emptyBodyLabel
                || body.isEmpty {
                body = NameSpace.emptyBodyLabel
            }
            
            if title == NameSpace.defaultTitleLabel && body == NameSpace.defaultBodyLabel {
                title = String()
                body = String()
            } else if title == NameSpace.emptyTitleLabel && body == NameSpace.emptyBodyLabel {
                title = String()
                body = String()
            }
            
            titleTextField.text = title
            bodyTextView.text = body
        }
    }
    
    private func configureUserInteraction(enable: Bool) {
        titleTextField.isUserInteractionEnabled = enable
        bodyTextView.isUserInteractionEnabled = enable
        datePicker.isUserInteractionEnabled = enable
    }
    
    private func configureText() {
        titleTextField.text = NameSpace.defaultTitleLabel
        titleTextField.textColor = .lightGray
        
        bodyTextView.text = NameSpace.defaultBodyLabel
        bodyTextView.textColor = .lightGray
    }
    
    private func setUpTopBarStackView() {
        if titleTextField.text == NameSpace.defaultTitleLabel,
           bodyTextView.text == NameSpace.defaultBodyLabel {
            topBarStackView.addArrangedSubview(topLeftButton)
        } else {
            topBarStackView.addArrangedSubview(topLeftButton)
        }
        topBarStackView.addArrangedSubview(stateLabel)
        topBarStackView.addArrangedSubview(topRightButton)
    }
    
    private func setUpContentStackView() {
        contentStackView.addArrangedSubview(titleTextField)
        contentStackView.addArrangedSubview(datePicker)
        contentStackView.addArrangedSubview(bodyTextView)
    }
    
    private func configureTextDelegate() {
        titleTextField.delegate = self
        bodyTextView.delegate = self
    }
    
    private func configureTopBarViewLayout() {
        popUpView.addSubview(topBarView)
        topBarView.addSubview(topBarStackView)
        
        NSLayoutConstraint.activate([
            topBarView.heightAnchor.constraint(equalTo: popUpView.heightAnchor, multiplier: 0.075),
            topBarView.widthAnchor.constraint(equalTo: popUpView.widthAnchor, multiplier: 1),
            topBarView.topAnchor.constraint(equalTo: popUpView.topAnchor),
            topBarView.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor),
            
            topBarStackView.widthAnchor.constraint(equalTo: topBarView.widthAnchor, multiplier: 0.9),
            topBarStackView.heightAnchor.constraint(equalTo: topBarView.heightAnchor, multiplier: 1),
            topBarStackView.centerXAnchor.constraint(equalTo: topBarView.centerXAnchor),
            topBarStackView.centerYAnchor.constraint(equalTo: topBarView.centerYAnchor)
        ])
    }
    
    private func configureContentStackViewLayout() {
        popUpView.addSubview(contentStackView)
        
        NSLayoutConstraint.activate([
            contentStackView.widthAnchor.constraint(equalTo: popUpView.widthAnchor, multiplier: 0.9),
            contentStackView.heightAnchor.constraint(equalTo: popUpView.heightAnchor, multiplier: 0.88),
            contentStackView.centerXAnchor.constraint(equalTo: topBarView.centerXAnchor),
            contentStackView.topAnchor.constraint(equalTo: topBarStackView.bottomAnchor, constant: 5),
            
            titleTextField.topAnchor.constraint(equalTo: contentStackView.topAnchor),
            titleTextField.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
            titleTextField.heightAnchor.constraint(equalTo: contentStackView.heightAnchor, multiplier: 0.1)
        ])
    }
    
    private func configureLayout() {
        addSubview(popUpView)
        configureTopBarViewLayout()
        configureContentStackViewLayout()
        
        NSLayoutConstraint.activate([
            popUpView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.85),
            popUpView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            popUpView.centerXAnchor.constraint(equalTo: centerXAnchor),
            popUpView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

// MARK: - UITextFieldDelegate

extension CustomPopUpView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.textColor == .lightGray
            || textField.text == NameSpace.emptyTitleLabel {
            textField.text = nil
            textField.textColor = UIColor.black
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.isEmpty == true {
            textField.text = NameSpace.defaultTitleLabel
            textField.textColor = .lightGray
        }
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if let textCount = textField.text?.count {
            if textCount < NameSpace.titleTextCountLimit {
                return true
            }
            return false
        }
        
        return false
    }
}

// MARK: - UITextViewDelegate

extension CustomPopUpView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray
            || textView.text == NameSpace.emptyBodyLabel {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text?.isEmpty == true {
            textView.text = NameSpace.defaultBodyLabel
            textView.textColor = .lightGray
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > NameSpace.bodyTextCountLimit {
            textView.deleteBackward()
        }
    }
}

// MARK: - NameSpace

private enum NameSpace {
    static let defaultTitleLabel = "Title"
    static let defaultBodyLabel = "내용을 입력해주세요. (1000자 제한)"
    static let emptyTitleLabel = "[제목없음]"
    static let emptyBodyLabel = "[내용없음]"
    
    static let titleTextCountLimit = 45
    static let bodyTextCountLimit = 1000
}
