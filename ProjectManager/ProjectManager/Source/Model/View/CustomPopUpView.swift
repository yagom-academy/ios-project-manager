//
//  CustomPopUpView.swift
//  ProjectManager
//
//  Created by yonggeun Kim on 2023/01/15.
//

import UIKit

class CustomPopUpView: UIView {
    
    // MARK: Properties
    
    private let popUpView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    private let topBarView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
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
        label.text = "TODO"
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .headline, compatibleWith: .none)
        return label
    }()
    private let editButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        return button
    }()
    private let doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Done", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        return button
    }()
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.masksToBounds = false
        textField.layer.shadowOffset = CGSize(width: 0, height: 4)
        textField.layer.shadowRadius = 5
        textField.layer.shadowOpacity = 0.3
        return textField
    }()
    
    override func draw(_ rect: CGRect) {
        setUpTopBarStackView()
        configureLayout()
    }
    
    // MARK: Private Methods
    
    private func setUpTopBarStackView() {
        topBarStackView.addArrangedSubview(editButton)
        topBarStackView.addArrangedSubview(stateLabel)
        topBarStackView.addArrangedSubview(doneButton)
    }
    
    private func configureTopBarLayout() {
        popUpView.addSubview(topBarView)
        topBarView.addSubview(topBarStackView)
        
        NSLayoutConstraint.activate([
            topBarView.heightAnchor.constraint(equalTo: popUpView.heightAnchor, multiplier: 0.08),
            topBarView.widthAnchor.constraint(equalTo: popUpView.widthAnchor, multiplier: 1),
            topBarView.topAnchor.constraint(equalTo: popUpView.topAnchor),
            topBarView.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor),
            
            topBarStackView.widthAnchor.constraint(equalTo: topBarView.widthAnchor, multiplier: 0.9),
            topBarStackView.heightAnchor.constraint(equalTo: topBarView.heightAnchor, multiplier: 1),
            topBarStackView.centerXAnchor.constraint(equalTo: topBarView.centerXAnchor),
            topBarStackView.centerYAnchor.constraint(equalTo: topBarView.centerYAnchor)
        ])
    }
    
    private func configureTitleTextField() {
        popUpView.addSubview(titleTextField)
        
        NSLayoutConstraint.activate([
            titleTextField.widthAnchor.constraint(equalTo: popUpView.widthAnchor, multiplier: 0.9),
            titleTextField.heightAnchor.constraint(equalTo: popUpView.heightAnchor, multiplier: 0.08),
            titleTextField.centerXAnchor.constraint(equalTo: topBarView.centerXAnchor),
            titleTextField.topAnchor.constraint(equalTo: topBarView.bottomAnchor, constant: 5)
        ])
    }
    
    private func configureLayout() {
        addSubview(popUpView)
        configureTopBarLayout()
        configureTitleTextField()
        
        NSLayoutConstraint.activate([
            popUpView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.85),
            popUpView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            popUpView.centerXAnchor.constraint(equalTo: centerXAnchor),
            popUpView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
