//
//  DetailViewController.swift
//  ProjectManager
//
//  Created by 김동욱 on 2022/07/08.
//

import UIKit

final class DetailViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar()
        self.setUpDetailView()
        self.setUpLayout()
    }
    
    private func setNavigationBar() {
        self.navigationItem.title = "TODO"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: nil, action: nil)
    }
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemBackground
        textField.placeholder = "Title"
        textField.font = UIFont.preferredFont(forTextStyle: .title3)
        textField.setContentHuggingPriority(.required, for: .vertical)
        textField.layer.cornerRadius = 10
        textField.layer.shadowOffset = CGSize(width: 3, height: 3)
        textField.layer.shadowOpacity = 0.3
        textField.layer.shadowRadius = 5
        
        return textField
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.setContentHuggingPriority(.required, for: .vertical)
        
        return datePicker
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .systemBackground
        textView.clipsToBounds = false
        textView.layer.cornerRadius = 10
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.layer.shadowOffset = CGSize(width: 3, height: 3)
        textView.layer.shadowOpacity = 0.3
        textView.layer.shadowRadius = 5

        return textView
    }()
    
    private let detailStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private func setUpDetailView() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(self.detailStackView)
        self.detailStackView.addArrangedSubviews(with: [self.titleTextField, self.datePicker, self.descriptionTextView])
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([
            self.titleTextField.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        NSLayoutConstraint.activate([
            self.detailStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.detailStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            self.detailStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            self.detailStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}
