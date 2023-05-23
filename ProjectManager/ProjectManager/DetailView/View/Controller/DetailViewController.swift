//
//  DetailViewController.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/22.
//

import UIKit
import Combine

final class DetailViewController: UIViewController {
    enum Mode {
        case create
        case update
    }
    
    private var navigationBar: UINavigationBar?
    
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
    
    private let detailViewModel: DetailViewModel
    
    let mode: Mode
    var cancellables = Set<AnyCancellable>()
    weak var delegate: TaskFetchDelegate?
    
    init(task: Task?, mode: Mode) {
        self.detailViewModel = DetailViewModel(task: task)
        self.mode = mode
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
        bind(to: detailViewModel)
    }

    private func bind(to viewModel: DetailViewModel) {
        assign(publisher: titleTextfield.textPublisher, keyPath: \.title)
        assign(publisher: bodyTextView.textPublisher, keyPath: \.body)
        assign(publisher: datePicker.datePublisher, keyPath: \.date)
        
        detailViewModel
            .isEditingDone
            .sink { isEditingDone in
                let rightBarButtonItem = self.navigationBar?.items?.last?.rightBarButtonItem
                rightBarButtonItem?.isEnabled = isEditingDone ? true : false
            }
            .store(in: &cancellables)
    }
    
    private func assign<Value>(
        publisher: AnyPublisher<Value, Never>,
        keyPath: ReferenceWritableKeyPath<DetailViewModel, Value>
    ) {
        publisher
            .assign(to: keyPath, on: detailViewModel)
            .store(in: &cancellables)
    }
    
    private func configureNavigationBar() {
        navigationBar = UINavigationBar(
            frame: .init(x: 0, y: 0, width: view.frame.width / 2 + 20, height: 50)
        )
        
        guard let navigationBar else {
            return
        }
        
        navigationBar.isTranslucent = false
        navigationBar.standardAppearance.backgroundColor = .systemGray6
        
        let navigationItem = UINavigationItem(title: "Todo")
        let rightNavigationButton = UIBarButtonItem(
            title: "Done",
            style: .plain,
            target: self,
            action: #selector(tapDoneButton)
        )
        
        rightNavigationButton.isEnabled = false
        
        navigationItem.rightBarButtonItem = rightNavigationButton
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Cancel",
            style: .plain,
            target: self,
            action: #selector(tapCancelButton)
        )
        navigationBar.items = [navigationItem]
        
        view.addSubview(navigationBar)
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
    
    @objc
    private func tapDoneButton() {
        switch mode {
        case .create:
            detailViewModel.createTask()
        case .update:
            detailViewModel.updateTask()
        }
        
        delegate?.fetchTaskList()
        self.dismiss(animated: true)
    }
    
    @objc
    private func tapCancelButton() {
        self.dismiss(animated: true)
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
            stackView.topAnchor.constraint(equalTo: safe.topAnchor, constant: 60),
            stackView.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -20),
        ])
    }
    
    private func configureLabelText() {
        self.titleTextfield.text = detailViewModel.title
        self.datePicker.date = detailViewModel.date
        self.bodyTextView.text = detailViewModel.body
    }
}
