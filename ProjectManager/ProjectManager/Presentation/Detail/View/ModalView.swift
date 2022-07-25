//
//  ModalView.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/05.
//

import UIKit

final class ModalView: UIView {
//    private var bottomConstraint: NSLayoutConstraint?
    
    lazy var titleTextField: UITextField = {
        let textField = UITextField()
        drawBorder(view: textField, color: .systemGray3)
        textField.font = .preferredFont(forTextStyle: .title3)
        textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 10.0))
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
    
    lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        drawBorder(view: textView, color: .systemGray3)
        textView.font = .preferredFont(forTextStyle: .title3)
        textView.textContainerInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 0)
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
        
        setUpBackgroundColor()
        setUpContents()
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func drawBorder(view: UIView, borderWidth: CGFloat = 2, color: UIColor) {
        view.layer.borderWidth = borderWidth
        view.layer.borderColor = color.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowColor = color.cgColor
        view.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
    
    private func setUpBackgroundColor() {
        backgroundColor = .systemBackground
    }
    
    private func setUpContents() {
        addSubview(scrollView)
        
        scrollView.addSubview(baseStackView)
        
        baseStackView.addArrangedSubview(titleTextField)
        baseStackView.addArrangedSubview(datePicker)
        baseStackView.addArrangedSubview(descriptionTextView)
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
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
            descriptionTextView.heightAnchor.constraint(greaterThanOrEqualTo: heightAnchor, multiplier: 0.57)
        ])
    }
    
    func compose(content: ProjectContent) {
        guard let formattedDate = DateFormatter().formatted(string: content.deadline) else {
            return
        }
        titleTextField.text = content.title
        datePicker.date = formattedDate
        descriptionTextView.text = content.body
    }
    
    func isUserInteractionEnabled(_ isEnable: Bool) {
        titleTextField.isUserInteractionEnabled = isEnable
        datePicker.isUserInteractionEnabled = isEnable
        descriptionTextView.isEditable = isEnable
    }
    
    func change(_ content: ProjectContent) -> ProjectContent {
        var newContent = content
        newContent.editContent(
            title: titleTextField.text,
            deadline: datePicker.date,
            body: descriptionTextView.text
        )
        
        return newContent
    }
    
    func adjustConstraint(by keyboardHeight: CGFloat) {
        scrollView.contentInset = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: keyboardHeight,
            right: 0
        )
    }
}
