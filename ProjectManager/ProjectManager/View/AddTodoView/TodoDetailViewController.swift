//
//  AddTodoViewController.swift
//  ProjectManager
//
//  Created by Finnn on 2022/09/09.
//

import UIKit
import RxSwift
import RxCocoa

class TodoDetailViewController: UIViewController {

    // MARK: - Properties
    
    var disposeBag = DisposeBag()
    var todoData: Observable<Todo>? {
        didSet {
            todoData?
                .map { $0.title }
                .bind(to: titleTextField.rx.text)
                .disposed(by: disposeBag)
            
            todoData?
                .map { $0.body }
                .bind(to: bodyTextView.rx.text)
                .disposed(by: disposeBag)
        }
    }
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 0))
        textField.font = .preferredFont(forTextStyle: .title2)
        textField.placeholder = "Title"
        textField.textAlignment = .left
        textField.leftViewMode = .always
        textField.leftView = leftPaddingView

        return textField
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.locale = .autoupdatingCurrent
        datePicker.timeZone = .autoupdatingCurrent
        datePicker.preferredDatePickerStyle = .wheels
        
        return datePicker
    }()
    
    private let bodyTextView: UITextView = {
        let textView = UITextView()
        textView.adjustsFontForContentSizeCategory = true
        textView.font = .preferredFont(forTextStyle: .body)
        textView.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        
        return textView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        return stackView
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBackgroundColor()
        configureHierarchy()
        configureLayout()
        configureNavigationBar()
        
        configureShadow(titleTextField)
        configureShadow(bodyTextView)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        disposeBag = DisposeBag()
    }
}

// MARK: - Configure Methods

extension TodoDetailViewController {
    private func configureNavigationBar() {
        title = "TODO"
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.backgroundColor = .systemGray6
        
        let cancelButton = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelButtonTapped)
        )
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneButtonTapped)
        )
        
        navigationItem.setLeftBarButton(cancelButton, animated: true)
        navigationItem.setRightBarButton(doneButton, animated: true)
    }
    
    private func configureBackgroundColor() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureHierarchy() {
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(titleTextField)
        stackView.addArrangedSubview(datePicker)
        stackView.addArrangedSubview(bodyTextView)
    }
    
    private func configureLayout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleTextField.heightAnchor.constraint(equalTo: datePicker.heightAnchor, multiplier: 0.2)
        ])
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePicker.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
        ])
    }
    
    private func configureShadow(_ view: UIView) {
        view.backgroundColor = .white
        view.clipsToBounds = false

        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.systemGray6.cgColor

        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 3.0
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowColor = UIColor.gray.cgColor
    }
}

// MARK: - Objective-C Methods

extension TodoDetailViewController {
    @objc private func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func doneButtonTapped() {
        dismiss(animated: true)
    }
}
