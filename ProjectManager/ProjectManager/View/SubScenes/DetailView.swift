//
//  DetailView.swift
//  ProjectManager
//
//  Created by Kyo on 2023/01/14.
//

import UIKit

final class DetailView: UIView {
    private enum UIConstant {
        static let textFieldHeight = 50.0
        static let topValue = 10.0
        static let leadingValue = 10.0
        static let trailingValue = -10.0
        static let bottomValue = -10.0
        static let borderWidth = 2.0
    }
    
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Title"
        textField.backgroundColor = .white
        textField.layer.borderWidth = UIConstant.borderWidth
        textField.layer.borderColor = UIColor.systemGray5.cgColor
        textField.font = .preferredFont(forTextStyle: .title1)
        return textField
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .white
        textView.layer.masksToBounds = false
        textView.layer.borderWidth = UIConstant.borderWidth
        textView.layer.borderColor = UIColor.systemGray5.cgColor
        textView.font = .preferredFont(forTextStyle: .title2)
        return textView
    }()
    
    let datePicker = UIDatePicker()
    
    private lazy var addStackView = UIStackView(
        views: [titleTextField, datePicker, descriptionTextView],
        axis: .vertical,
        alignment: .fill,
        distribution: .fill,
        spacing: 10
    )
    
    init() {
        super.init(frame: .zero)
        setupView()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UIConfiguration
extension DetailView {
    private func setupView() {
        backgroundColor = .white
        titleTextField.setPadding(padding: 20)
        [titleTextField, descriptionTextView].forEach {
            $0.layer.shadowOpacity = 0.5
            $0.layer.shadowRadius = 0.3
            $0.layer.shadowOffset = CGSize(width: 1, height: 3)
            $0.layer.shadowColor = UIColor.black.cgColor
        }
        addSubview(addStackView)
    }
    
    private func setupConstraint() {
        let safeArea = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            titleTextField.heightAnchor.constraint(
                equalToConstant: UIConstant.textFieldHeight
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
