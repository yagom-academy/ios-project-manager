//
//  TodoView.swift
//  ProjectManager
//
//  Created by 애쉬 on 2023/01/14.
//

import UIKit

final class TodoView: UIView {
    let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " Title"
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.systemGray5.cgColor
        return textField
    }()
    
    let bodyTextView: UITextView = {
        let textView = UITextView()
        textView.text = """
                        할일의 내용을 입력해주세요.
                        입력 가능한 글자수는 1000자로 제한됩니다.
                        """
        textView.layer.cornerRadius = 5
        textView.layer.borderWidth = 2
        textView.font = UIFont.preferredFont(forTextStyle: .body, compatibleWith: .none)
        textView.layer.borderColor = UIColor.systemGray5.cgColor
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        mainStackView.addArrangedSubview(titleTextField)
        mainStackView.addArrangedSubview(bodyTextView)
        addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            mainStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            mainStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            titleTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
