//
//  ModalView.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/05.
//

import UIKit

final class ModalView: UIView {
    let navigationBar = ModalNavigationBar()
    let defaultTopConstant = (UIScreen.main.bounds.height - ModalConstant.modalFrameHeight) / 2
    weak var delegate: ModalDelegate?
    
    lazy var titleTextField: UITextField = {
        let textField = UITextField()
        drawBorder(view: textField, color: .systemGray6)
        textField.font = .preferredFont(forTextStyle: .title3)
        textField.leftView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 10,
                height: 0
            )
        )
        textField.leftViewMode = .always
        textField.placeholder = "title"
        return textField
    }()
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        return datePicker
    }()
    
    lazy var bodyTextView: UITextView = {
        let textView = UITextView()
        drawBorder(view: textView, color: .systemGray6)
        textView.font = .preferredFont(forTextStyle: .title3)
        textView.textContainerInset = UIEdgeInsets(
            top: 5,
            left: 5,
            bottom: 5,
            right: 0
        )
        textView.isScrollEnabled = false
        return textView
    }()
    
    private let baseStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpAttribute()
        setUpContents()
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func drawBorder(view: UIView, color: UIColor) {
        view.layer.borderWidth = 1
        view.layer.borderColor = color.cgColor
        view.layer.cornerRadius = 5
    }
    
    private func setUpAttribute() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 10
    }
    
    private func setUpContents() {
        addSubview(navigationBar)
        addSubview(scrollView)
        
        scrollView.addSubview(baseStackView)
        
        baseStackView.addArrangedSubview(titleTextField)
        baseStackView.addArrangedSubview(datePicker)
        baseStackView.addArrangedSubview(bodyTextView)
    }
    
    private func setUpLayout() {
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: topAnchor),
            navigationBar.bottomAnchor.constraint(equalTo: scrollView.topAnchor, constant: -10),
            navigationBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            navigationBar.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])

        NSLayoutConstraint.activate([
            baseStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            baseStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            baseStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            baseStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            baseStackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            datePicker.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25)
        ])
        
        NSLayoutConstraint.activate([
            bodyTextView.heightAnchor.constraint(greaterThanOrEqualTo: heightAnchor, multiplier: 0.57)
        ])
    }
    
    func compose(content: ProjectEntity) {
        guard let formattedDate = DateFormatter().formatted(string: content.deadline) else {
            return
        }
        titleTextField.text = content.title
        datePicker.date = formattedDate
        bodyTextView.text = content.body
    }
    
    func isUserInteractionEnabled(_ isEnable: Bool) {
        titleTextField.isUserInteractionEnabled = isEnable
        datePicker.isUserInteractionEnabled = isEnable
        bodyTextView.isEditable = isEnable
        
        changeColor(isEnable)
    }
    
    func change(_ content: ProjectEntity) -> ProjectEntity {
        var newContent = content
        newContent.editContent(
            title: titleTextField.text,
            deadline: datePicker.date,
            body: bodyTextView.text
        )
        
        return newContent
    }
    
    private func adjustConstraint(by keyboardHeight: CGFloat) {
        scrollView.contentInset = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: keyboardHeight,
            right: 0
        )
    }
    
    private func changeColor(_ isEnable: Bool) {
        let backgroundColor = isEnable ? UIColor.systemBackground : UIColor.systemGray6
        let boundColor = isEnable ? UIColor.systemGray3 : UIColor.systemGray6
        
        titleTextField.backgroundColor = backgroundColor
        bodyTextView.backgroundColor = backgroundColor
        drawBorder(view: titleTextField, color: boundColor)
        drawBorder(view: bodyTextView, color: boundColor)
    }
}

extension ModalView {
    func registerNotification() {
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        notificationCenter.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {
            return
        }
        
        let keyboardInfo = userInfo[UIResponder.keyboardFrameEndUserInfoKey]
        
        guard let keyboardSize = (keyboardInfo as? NSValue)?.cgRectValue else {
            return
        }
        
        if titleTextField.isFirstResponder == true {
            delegate?.changeModalViewTopConstant(to: ModalConstant.minTopConstant)
        }
        
        if bodyTextView.isFirstResponder == true {
            adjustConstraint(by: keyboardSize.height - 2 * defaultTopConstant + ModalConstant.minTopConstant)
            delegate?.changeModalViewTopConstant(to: ModalConstant.minTopConstant)
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        adjustConstraint(by: .zero)
        delegate?.changeModalViewTopConstant(to: defaultTopConstant)
    }
}
