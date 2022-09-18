//
//  ProjectAdditionScrollView.swift
//  ProjectManager
//
//  Created by 수꿍, 휴 on 2022/09/11.
//

import UIKit
import OSLog

final class ProjectAdditionScrollView: UIScrollView {
    private let scheduleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.layoutMargins = UIEdgeInsets(
            top: 15,
            left: 15,
            bottom: 15,
            right: 15
        )
        stackView.isLayoutMarginsRelativeArrangement = true
        
        return stackView
    }()
    
    let scheduleTitleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .systemBackground
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.systemGray2.cgColor
        textField.placeholder = "Title"
        textField.font = UIFont.preferredFont(forTextStyle: .callout)
        textField.setContentHuggingPriority(.required, for: .vertical)
        textField.layer.shadowOpacity = 1
        textField.layer.shadowOffset = CGSize(width: 0, height: 2)
        textField.layer.shadowColor = UIColor.gray.cgColor
        textField.clearButtonMode = .whileEditing
        
        return textField
    }()
    
    let datePicker: UIDatePicker? = {
        let datePicker = UIDatePicker()
        
        guard let localeID = Locale.preferredLanguages.first,
              let deviceLocale = Locale(identifier: localeID).languageCode else {
            return nil
        }
        
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: deviceLocale)
        datePicker.minimumDate = Date()
        datePicker.setContentHuggingPriority(.required, for: .vertical)
        
        return datePicker
    }()
    
    let scheduleDescriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        textView.text = "Description"
        textView.font = UIFont.preferredFont(forTextStyle: .caption1)
        
        return textView
    }()
    
    private let shadowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowColor = UIColor.gray.cgColor
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.alwaysBounceVertical = true
        
        configureView()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        os_log(.default, log: .ui, "didn't use nib File")
    }
    
    private func configureView() {
        guard let datePicker = datePicker else {
            return
        }
        
        self.addSubview(scheduleStackView)
        shadowView.addSubview(scheduleDescriptionTextView)
        scheduleStackView.addArrangedSubview(scheduleTitleTextField)
        scheduleStackView.addArrangedSubview(datePicker)
        scheduleStackView.addArrangedSubview(shadowView)
    }
    
    private func configureUI() {
        NSLayoutConstraint.activate([
            scheduleStackView.topAnchor.constraint(equalTo: self.topAnchor),
            scheduleStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scheduleStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scheduleStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scheduleStackView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            scheduleDescriptionTextView.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor),
            scheduleDescriptionTextView.topAnchor.constraint(equalTo: shadowView.topAnchor),
            scheduleDescriptionTextView.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor),
            scheduleDescriptionTextView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor)
        ])
    }
    
    func setContent(data: ProjectUnit) {
        scheduleTitleTextField.text = data.title
        scheduleDescriptionTextView.text = data.body
        datePicker?.date = data.deadLine
    }
}
