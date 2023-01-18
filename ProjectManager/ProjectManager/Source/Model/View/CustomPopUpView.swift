//
//  CustomPopUpView.swift
//  ProjectManager
//
//  Created by yonggeun Kim on 2023/01/15.
//

import UIKit

class CustomPopUpView: UIView {
    
    // MARK: Properties
    
    let editButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        return button
    }()
    let doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Done", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        return button
    }()
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
        label.text = "TODO"
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
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.masksToBounds = false
        textField.layer.shadowOffset = CGSize(width: 0, height: 4)
        textField.layer.shadowRadius = 5
        textField.layer.shadowOpacity = 0.3
        return textField
    }()
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "en-EN")
        datePicker.timeZone = .autoupdatingCurrent
        return datePicker
    }()
    private let bodyTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setContentHuggingPriority(.defaultLow, for: .vertical)
        textField.backgroundColor = .white
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.masksToBounds = false
        textField.layer.shadowOffset = CGSize(width: 0, height: 4)
        textField.layer.shadowRadius = 5
        textField.layer.shadowOpacity = 0.3
        return textField
    }()
    
    // MARK: Initializer
    
    override func draw(_ rect: CGRect) {
        setUpTopBarStackView()
        setUpContentStackView()
        configureLayout()
    }
    
    // MARK: Internal Methods
    
    func saveProjectData() -> ProjectData? {
        if let title = titleTextField.text,
           let body = bodyTextField.text {
            let projectData: ProjectData = ProjectData(
                title: title,
                body: body,
                deadline: 100
            )
            
            return projectData
        }
        
        return nil
    }
    
    func showProjectData(with projectData: ProjectData) {
        titleTextField.text = projectData.title
        bodyTextField.text = projectData.body
    }
    
    // MARK: Private Methods
    
    private func setUpTopBarStackView() {
        topBarStackView.addArrangedSubview(editButton)
        topBarStackView.addArrangedSubview(stateLabel)
        topBarStackView.addArrangedSubview(doneButton)
    }
    
    private func setUpContentStackView() {
        contentStackView.addArrangedSubview(titleTextField)
        contentStackView.addArrangedSubview(datePicker)
        contentStackView.addArrangedSubview(bodyTextField)
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
