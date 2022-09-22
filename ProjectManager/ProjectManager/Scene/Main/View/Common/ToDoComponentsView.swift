//
//  ToDoComponentsView.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/11.
//

import UIKit

final class ToDoComponentsView: UIView {
    
    // MARK: - Properties
    
    private let titleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = Design.titleViewLayerBorderWidth
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.shadowOffset = Design.titleViewLayerShaodwOffset
        view.layer.shadowRadius = Design.titleViewLayerShaodwRadius
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = Design.titleViewLayerShaodwOpacity
        view.backgroundColor = .systemBackground
        
        return view
    }()
    
    private let descriptionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = Design.descriptionViewLayerBorderWidth
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.shadowOffset = Design.descriptionViewLayerShaodwOffset
        view.layer.shadowRadius = Design.descriptionViewLayerShaodwRadius
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = Design.descriptionViewLayerShaodwOpacity
        view.backgroundColor = .systemBackground
        
        return view
    }()
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isUserInteractionEnabled = false
        
        return textField
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isUserInteractionEnabled = false
        
        return textView
    }()
    
    private var timeLimitDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.isUserInteractionEnabled = false
        
        return datePicker
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Functions
    
    func fetchItem() -> ToDoItem {
        
        return ToDoItem(title: titleTextField.text ?? "",
                        description: descriptionTextView.text ?? "",
                        timeLimit: timeLimitDatePicker.date)
    }
    
    func configure(of item: ToDoItem) {
        titleTextField.text = item.title
        descriptionTextView.text = item.description
        timeLimitDatePicker.setDate(item.timeLimit, animated: true)
    }
    
    func setupEditable(is tapped: Bool) {
        if tapped {
            titleTextField.isUserInteractionEnabled = true
            timeLimitDatePicker.isUserInteractionEnabled = true
            descriptionTextView.isUserInteractionEnabled = true
        }
    }
    
    private func commonInit() {
        setupSubviews()
        setupStackViewLayout()
    }
    
    private func setupSubviews() {
        titleView.addSubview(titleTextField)
        descriptionView.addSubview(descriptionTextView)
        
        [titleView, timeLimitDatePicker, descriptionView]
            .forEach { self.addSubview($0) }
    }
    
    private func setupStackViewLayout() {
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            titleView.bottomAnchor.constraint(equalTo: timeLimitDatePicker.topAnchor, constant: -20),
            titleView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: titleView.topAnchor, constant: 20),
            titleTextField.bottomAnchor.constraint(equalTo: titleView.bottomAnchor, constant: -20),
            titleTextField.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: titleView.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            timeLimitDatePicker.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 20),
            timeLimitDatePicker.bottomAnchor.constraint(equalTo: descriptionView.topAnchor, constant: -20),
            timeLimitDatePicker.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            timeLimitDatePicker.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            descriptionView.topAnchor.constraint(equalTo: timeLimitDatePicker.bottomAnchor, constant: 20),
            descriptionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            descriptionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            descriptionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: 20),
            descriptionTextView.bottomAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: -20),
            descriptionTextView.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: 20),
            descriptionTextView.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor, constant: -20)
        ])
    }
    
    // MARK: - Name Space
    
    private enum Design {
        static let titleViewLayerBorderWidth = 1.0
        static let titleViewLayerShaodwOffset = CGSize(width: 3, height: 3)
        static let titleViewLayerShaodwRadius = 5.0
        static let titleViewLayerShaodwOpacity: Float = 0.8
        static let descriptionViewLayerBorderWidth = 1.0
        static let descriptionViewLayerShaodwOffset = CGSize(width: 3, height: 3)
        static let descriptionViewLayerShaodwRadius = 5.0
        static let descriptionViewLayerShaodwOpacity: Float = 0.8
    }
}
