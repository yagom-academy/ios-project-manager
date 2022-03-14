//
//  ProjectDetailViewController.swift
//  ProjectManager
//
//  Created by 1 on 2022/03/07.
//

import UIKit

// MARK: - ProjectCreatorViewControllerDelegate
protocol ProjectCreatorViewControllerDelegate {
    
    func createProject(with content: [String: Any])
}

// MARK: - ProjectCreatorViewController
class ProjectCreatorViewController: UIViewController {
    
    // MARK: - Property
    weak var delegate: ProjectBoardViewController?
    
    // MARK: - UI Property
    private var navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        return navigationBar
    }()
    
    private var titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.font = .preferredFont(forTextStyle: .body, compatibleWith: nil)
        textField.placeholder = "Title"
        textField.layer.shadowOffset = CGSize(width: 3, height: 3)
        textField.layer.shadowOpacity = 0.3
        textField.layer.shadowRadius = 3
        return textField
    }()
    
    private var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        var preferredLanguage = Locale.preferredLanguages.first
        let currentRegionIdentifier: Substring? = NSLocale.current.identifier.split(separator: "_").last
        if let languageCode = preferredLanguage, let regionCode = currentRegionIdentifier {
            let deviceLocaleIdentifier = "\(languageCode)_\(regionCode)"
            datePicker.locale = Locale(identifier: deviceLocaleIdentifier)
            return datePicker
        }
        return datePicker
    }()
    
    private var descriptionTextViewContainer: UIView = {
        let view = UIView(frame: .zero)
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowOpacity = 0.3
        view.layer.shadowRadius = 3
        view.layer.masksToBounds = false
        return view
    }()
    
    private var descriptionTextView: UITextView = {
        let textView = UITextView(frame: .zero)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .systemGray6
        textView.font = .preferredFont(forTextStyle: .body)
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        textView.layer.masksToBounds = true
        return textView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews:
                                        [titleTextField, datePicker, descriptionTextViewContainer])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    // MARK: - View Life Cycle
    override func loadView() {
        self.view = .init()
        self.view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        self.configureNavigationItem()
        self.configureNavigationBarLayout()
        self.configureStackViewLayout()
    }
    
    // MARK: - Configure View
    private func configureNavigationItem() {
        let navigationItem = UINavigationItem()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: self,
                                         action: #selector(dismissWithCreation))
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel,
                                           target: self,
                                           action: #selector(dismissWithoutCreation))
        navigationItem.rightBarButtonItem = doneButton
        navigationItem.leftBarButtonItem = cancelButton
        
        navigationBar.items = [navigationItem]
    }
    
    private func configureNavigationBarLayout() {
        self.view.addSubview(navigationBar)
        let safeArea = self.view.safeAreaLayoutGuide
        navigationBar.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        navigationBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        navigationBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
    }
    
    private func configureStackViewLayout() {
        self.descriptionTextViewContainer.addSubview(descriptionTextView)
        self.view.addSubview(stackView)
        let safeArea = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([titleTextField.heightAnchor.constraint(equalToConstant: 45)])
        
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: descriptionTextViewContainer.topAnchor),
            descriptionTextView.bottomAnchor.constraint(equalTo: descriptionTextViewContainer.bottomAnchor),
            descriptionTextView.leadingAnchor.constraint(equalTo: descriptionTextViewContainer.leadingAnchor),
            descriptionTextView.trailingAnchor.constraint(equalTo: descriptionTextViewContainer.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            descriptionTextViewContainer.topAnchor.constraint(equalTo: datePicker.bottomAnchor),
            descriptionTextViewContainer.bottomAnchor.constraint(equalTo: stackView.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 15),
            stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -15),
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -15)
        ])
    }
    
    // MARK: - @objc Method
    @objc func dismissWithoutCreation() {
        dismiss(animated: false, completion: nil)
    }
    
    @objc func dismissWithCreation() {
        var content: [String: Any] = [:]
        content.updateValue(titleTextField.text as Any, forKey: "title")
        content.updateValue(datePicker.date as Any, forKey: "deadline")
        content.updateValue(descriptionTextView.text as Any, forKey: "description")
        delegate?.createProject(with: content)
        dismiss(animated: false, completion: nil)
    }
}
