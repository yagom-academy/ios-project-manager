//
//  TaskFormViewController.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/22.
//

import UIKit
import Combine

final class TaskFormViewController: UIViewController {
    private let viewModel: TaskFormViewModel
    private var subscriptions = Set<AnyCancellable>()

    private let stackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.backgroundColor = .systemBackground
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        
        return stackView
    }()
    
    private let textField = {
        let textField = UITextField()
        let placeholderText = "Title"
        
        textField.backgroundColor = .systemBackground
        textField.placeholder = placeholderText
        textField.font = .preferredFont(forTextStyle: .title1)
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.shadowOffset = CGSize(width: 0, height: 3)
        textField.layer.shadowOpacity = 0.3
        textField.layer.shadowRadius = 5.0
        
        return textField
    }()
    
    private let datePicker = {
        let datePicker = UIDatePicker()
        
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        
        return datePicker
    }()
    
    private let textView = {
        let textView = UITextView()
        
        textView.font = .preferredFont(forTextStyle: .body)
        textView.clipsToBounds = false
        textView.layer.shadowColor = UIColor.black.cgColor
        textView.layer.shadowOffset = CGSize(width: 0, height: 3)
        textView.layer.shadowOpacity = 0.3
        textView.layer.shadowRadius = 5.0
        textView.textContainerInset = .init(top: 5, left: 5, bottom: 5, right: 5)
        
        return textView
    }()
    
    init(task: MyTask? = nil) {
        viewModel = TaskFormViewModel(task: task)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray5
        
        setupNavigationBar()
        setupStackView()
        setupStackViewConstraints()
        setupContents()
        bind()
    }
    
    private func setupNavigationBar() {
        let leftBarbutton = UIBarButtonItem(title: viewModel.leftBarButtonTitle,
                                            style: .plain,
                                            target: self,
                                            action: #selector(leftBarButtonAction))
        let rightBarbutton = UIBarButtonItem(title: viewModel.rightBarButtonTitle,
                                            style: .plain,
                                            target: self,
                                            action: #selector(rightBarButtonAction))

        navigationItem.title = viewModel.navigationTitle
        navigationItem.leftBarButtonItem = leftBarbutton
        navigationItem.rightBarButtonItem = rightBarbutton
    }
    
    @objc private func leftBarButtonAction() {
        let action: (() -> Void)? = { [weak self] in
            self?.dismiss(animated: true)
        }
        
        viewModel.cancelOrEditAction(action: action)
    }
    
    @objc private func rightBarButtonAction() {
        viewModel.doneAction(title: textField.text ?? "",
                             date: datePicker.date.timeIntervalSince1970,
                             body: textView.text ?? "")
        
        dismiss(animated: true)
    }
    
    private func setupStackViewConstraints() {
        let safe = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safe.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safe.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: safe.bottomAnchor),
            
            textField.heightAnchor.constraint(equalTo: datePicker.heightAnchor, multiplier: 0.25)
        ])
    }
    
    private func setupStackView() {
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(datePicker)
        stackView.addArrangedSubview(textView)
    }
    
    private func setupContents() {
        textField.text = viewModel.title
        datePicker.setDate(Date(timeIntervalSince1970: viewModel.deadline), animated: false)
        textView.text = viewModel.body
    }
    
    private func bind() {
        bindContentsEditable()
        bindLeftBarButtonEnable()
        bindDoneButtonEnable()
        assignToTitle()
        assignToBody()
    }
    
    private func bindContentsEditable() {
        viewModel.$isEditable
            .sink { [weak self] in
                self?.textField.isEnabled = $0
                self?.datePicker.isEnabled = $0
                self?.textView.isEditable = $0
            }
            .store(in: &subscriptions)
    }
    
    private func bindLeftBarButtonEnable() {
        viewModel.isNetworkConnectedPublisher()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.navigationItem.leftBarButtonItem?.isEnabled = $0
            }
            .store(in: &subscriptions)
    }
    
    private func bindDoneButtonEnable() {
        viewModel.$isDone
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.navigationItem.rightBarButtonItem?.isEnabled = $0
            }
            .store(in: &subscriptions)
    }
    
    private func assignToTitle() {
        textField.textPublisher
            .assign(to: \.title, on: viewModel)
            .store(in: &subscriptions)
    }
    
    private func assignToBody() {
        textView.textPublisher
            .assign(to: \.body, on: viewModel)
            .store(in: &subscriptions)
    }
}
