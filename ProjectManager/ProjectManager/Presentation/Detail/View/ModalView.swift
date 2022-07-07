//
//  ModalView.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/05.
//

import UIKit

final class ModalView: UIView {
    lazy var titleTextField: UITextField = {
        let textField = UITextField()
        drawShadow(view: textField, color: .systemGray3)
        textField.placeholder = "title"
        textField.setContentCompressionResistancePriority(.required, for: .vertical)
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
        drawShadow(view: textView, borderWidth: 5, color: .systemGray3)
        return textView
    }()
    
    private let baseStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
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
    
    private func drawShadow(view: UIView, borderWidth: CGFloat = 1, color: UIColor) {
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
        addSubview(baseStackView)
        
        baseStackView.addArrangedSubview(titleTextField)
        baseStackView.addArrangedSubview(datePicker)
        baseStackView.addArrangedSubview(descriptionTextView)
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([
            baseStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            baseStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            baseStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            baseStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    func compose(content: ProjectContent) {
        titleTextField.text = content.title
        datePicker.date = content.asProjectItem()?.deadline ?? Date()
        descriptionTextView.text = content.description
    }
    
    func isUserInteractionEnabled(_ isEnable: Bool) {
        titleTextField.isUserInteractionEnabled = isEnable
        datePicker.isUserInteractionEnabled = isEnable
        descriptionTextView.isUserInteractionEnabled = isEnable
    }
}
