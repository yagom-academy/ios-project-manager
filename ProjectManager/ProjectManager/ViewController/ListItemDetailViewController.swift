//
//  ListItemDetailViewController.swift
//  ProjectManager
//
//  Created by sole on 2021/03/09.
//

import UIKit

class ListItemDetailViewController: UIViewController {
    private let titleTextField: UITextField = {
        let titleTextField = UITextField()
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.placeholder = "Title"
        titleTextField.borderStyle = .roundedRect
        titleTextField.layer.shadowColor = UIColor.systemGray4.cgColor
        titleTextField.layer.masksToBounds = false
        titleTextField.layer.shadowOffset = CGSize(width: 5, height: 5)
        titleTextField.layer.shadowRadius = 1
        titleTextField.layer.shadowOpacity = 1
        return titleTextField
    }()
    private let deadLineDatePicker: UIDatePicker = {
        let deadLineDatePicker = UIDatePicker()
        deadLineDatePicker.translatesAutoresizingMaskIntoConstraints = false
        deadLineDatePicker.preferredDatePickerStyle = .wheels
        deadLineDatePicker.datePickerMode = .date
        deadLineDatePicker.timeZone = NSTimeZone.local
        return deadLineDatePicker
    }()
    private let checkboxButton: UIButton = {
        let checkboxButton = UIButton()
        checkboxButton.translatesAutoresizingMaskIntoConstraints = false
        checkboxButton.setTitle("날짜 선택 안함", for: .normal)
        checkboxButton.setTitleColor(.black, for: .normal)
        checkboxButton.setImage(UIImage(systemName: "square"), for: .normal)
        checkboxButton.setImage(UIImage(systemName: "square.fill"), for: .selected)
        checkboxButton.addTarget(self, action: #selector(touchUpCheckboxButton), for: .touchUpInside)
        return checkboxButton
    }()
    private let descriptionTextView: UITextView = {
        let descriptionTextView = UITextView()
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.font = .preferredFont(forTextStyle: .body)
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.borderColor = UIColor.systemGray.cgColor
        descriptionTextView.layer.cornerRadius = 5
        descriptionTextView.layer.shadowColor = UIColor.systemGray4.cgColor
        descriptionTextView.layer.masksToBounds = false
        descriptionTextView.layer.shadowOffset = CGSize(width: 5, height: 5)
        descriptionTextView.layer.shadowRadius = 1
        descriptionTextView.layer.shadowOpacity = 1
        return descriptionTextView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(titleTextField)
        view.addSubview(deadLineDatePicker)
        view.addSubview(checkboxButton)
        view.addSubview(descriptionTextView)
        configureAutoLayout()
    }
    
    private func configureAutoLayout() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            titleTextField.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            titleTextField.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.95),
            titleTextField.heightAnchor.constraint(equalToConstant: 80),
            
            deadLineDatePicker.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 10),
            deadLineDatePicker.centerXAnchor.constraint(equalTo: titleTextField.centerXAnchor),
            deadLineDatePicker.widthAnchor.constraint(equalTo: titleTextField.widthAnchor),
            
            checkboxButton.topAnchor.constraint(equalTo: deadLineDatePicker.bottomAnchor, constant: 10),
            checkboxButton.trailingAnchor.constraint(equalTo: deadLineDatePicker.trailingAnchor),
            
            descriptionTextView.topAnchor.constraint(equalTo: checkboxButton.bottomAnchor, constant: 10),
            descriptionTextView.centerXAnchor.constraint(equalTo: titleTextField.centerXAnchor),
            descriptionTextView.widthAnchor.constraint(equalTo: titleTextField.widthAnchor),
            descriptionTextView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -30)
        ])
    }
    
    @objc private func touchUpCheckboxButton(_ sender: UIButton) {
        sender.isSelected.toggle()
        deadLineDatePicker.isEnabled.toggle()
    }
}
