//
//  DetailViewController.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/22.
//

import UIKit
import Combine

final class DetailViewController: UIViewController {
    private let titleTextfield = {
        let textField = UITextField()
        textField.font = .preferredFont(forTextStyle: .title3)
        textField.backgroundColor = .white
        textField.placeholder = "Title"
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.systemGray6.cgColor
        textField.layer.masksToBounds = false
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.shadowOffset = CGSize(width: 0, height: 4)
        textField.layer.shadowOpacity = 0.3
        textField.layer.shadowRadius = 1.0
        
        return textField
    }()
    
    private let datePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        return datePicker
    }()
    
    private let bodyTextView = {
        let textView = UITextView()
        textView.font = .preferredFont(forTextStyle: .title3)
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    private let shadowView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.systemGray6.cgColor
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowOpacity = 0.3
        view.layer.shadowRadius = 1.0
        return view
    }()
    
    private let stackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    weak var delegate: DetailViewModelDelegate?
    
    private let viewModel: DetailViewModel
    private var bindings = Set<AnyCancellable>()
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        configureNavigationBar()
        configureShadowView()
        configureStackView()
        configureRootView()
        configureLabelText()
        configureUIEditability()
        
        bindViewToViewModel()
        bindViewModelToView()
    }
    
    func configureViewModelDelegate(with delegate: DetailViewModelDelegate?) {
        viewModel.delegate = delegate
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = "TODO"
        let rightNavigationButton = UIBarButtonItem(
            title: "Done",
            style: .plain,
            target: self,
            action: #selector(doneButtonTapped)
        )
        
        rightNavigationButton.isEnabled = false
        self.navigationItem.rightBarButtonItem = rightNavigationButton
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: viewModel.mode.leftButtonTitle,
            style: .plain,
            target: self,
            action: #selector(cancelButtonTapped)
        )
    }
    
    @objc
    private func doneButtonTapped() {
        switch viewModel.mode {
        case .create:
            viewModel.createPlan()
        case .update:
            viewModel.updatePlan()
        }
        
        self.dismiss(animated: true)
    }
    
    @objc
    private func cancelButtonTapped() {
        if viewModel.mode == .create {
            self.dismiss(animated: true)
            return
        }
        
        setUIUserInteraction(isEnable: true)
    }
    
    private func configureShadowView() {
        shadowView.addSubview(bodyTextView)
        
        NSLayoutConstraint.activate([
            bodyTextView.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor),
            bodyTextView.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor),
            bodyTextView.topAnchor.constraint(equalTo: shadowView.topAnchor),
            bodyTextView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor),
        ])
    }
    
    private func configureStackView() {
        stackView.addArrangedSubview(titleTextfield)
        stackView.addArrangedSubview(datePicker)
        stackView.addArrangedSubview(shadowView)
    }
    
    private func configureRootView() {
        self.view.backgroundColor = .white
        self.view.addSubview(stackView)
        
        let safe = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: safe.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -20),
        ])
    }
    
    private func configureLabelText() {
        self.titleTextfield.text = viewModel.title
        self.datePicker.date = viewModel.date
        self.bodyTextView.text = viewModel.body
    }
    
    private func configureUIEditability() {
        if viewModel.mode == .update {
            setUIUserInteraction(isEnable: false)
        }
    }
    
    private func setUIUserInteraction(isEnable: Bool) {
        titleTextfield.isUserInteractionEnabled = isEnable
        datePicker.isUserInteractionEnabled = isEnable
        bodyTextView.isUserInteractionEnabled = isEnable
    }
    
    private func bindViewToViewModel() {
        assign(publisher: titleTextfield.textPublisher, keyPath: \.title)
        assign(publisher: bodyTextView.textPublisher, keyPath: \.body)
        assign(publisher: datePicker.datePublisher, keyPath: \.date)
    }
    
    private func assign<Value>(
        publisher: AnyPublisher<Value, Never>,
        keyPath: ReferenceWritableKeyPath<DetailViewModel, Value>
    ) {
        publisher
            .assign(to: keyPath, on: viewModel)
            .store(in: &bindings)
    }
    
    private func bindViewModelToView() {
        viewModel
            .isEditingDone
            .tryCatch { error -> AnyPublisher<Bool, Error> in
                throw error
            }
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print(error)
                }
            }, receiveValue: { isEditingDone in
                self.navigationItem.rightBarButtonItem?.isEnabled = isEditingDone ? true : false
            })
            .store(in: &bindings)
    }
}
