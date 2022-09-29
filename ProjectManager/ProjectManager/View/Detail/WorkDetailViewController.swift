//
//  ManageWorkViewController.swift
//  ProjectManager
//
//  Created by Judy on 2022/09/09.
//

import UIKit
import RxRelay
import RxSwift

final class WorkDetailViewController: UIViewController {
    // MARK: - Inner types
    private enum ViewMode {
        case add
        case edit
    }
    
    // MARK: - UI
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Title"
        textField.borderStyle = .roundedRect
        textField.font = .preferredFont(forTextStyle: .body)
        textField.adjustsFontForContentSizeCategory = true
        textField.isEnabled = false
        textField.applyShadow()
        return textField
    }()
    
    private let deadlinePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.backgroundColor = .systemBackground
        datePicker.isEnabled = false
        datePicker.locale = Locale(identifier: Locale.preferredLanguages.first ?? "ko")
        return datePicker
    }()
    
    private let contentTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .preferredFont(forTextStyle: .body)
        textView.adjustsFontForContentSizeCategory = true
        textView.isEditable = false
        textView.applyShadow()
        return textView
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 16
        return stackView
    }()
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    private let viewModel: WorkViewModel
    private var viewMode: ViewMode?
    private var work: Work?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addSubView()
        setupConstraints()
    }
    
    // MARK: - initializer
    init(viewModel: WorkViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI setup
    private func addSubView() {
        self.view.backgroundColor = .systemGray6
        
        verticalStackView.addArrangedSubview(titleTextField)
        verticalStackView.addArrangedSubview(deadlinePicker)
        verticalStackView.addArrangedSubview(contentTextView)
        
        self.view.addSubview(verticalStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            verticalStackView.leadingAnchor
                .constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            verticalStackView.trailingAnchor
                .constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            verticalStackView.topAnchor
                .constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8),
            verticalStackView.bottomAnchor
                .constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            
            contentTextView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.6)
        ])
    }
    
    private func configureUI() {
        guard let viewMode = viewMode else { return }

        let cancleBarButton = UIBarButtonItem(title: "Cancle",
                                              style: .plain,
                                              target: self,
                                              action: #selector(cancelBarButtonTapped))
        let doneBarButton = UIBarButtonItem(title: "Done",
                                            style: .done,
                                            target: self,
                                            action: #selector(doneBarButtonTapped))
        let editBarButton = UIBarButtonItem(title: "Edit",
                                            style: .done,
                                            target: self,
                                            action: #selector(editBarButtonTapped))
        
        switch viewMode {
        case .add:
            self.navigationItem.leftBarButtonItem = cancleBarButton
            self.navigationItem.title = "TODO"
        case .edit:
            self.navigationItem.leftBarButtonItem = editBarButton
            self.navigationItem.title = work?.state.rawValue
        }
        
        self.navigationItem.rightBarButtonItem = doneBarButton
    }

    // MARK: - Methods
    @objc private func cancelBarButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc private func editBarButtonTapped() {
        switchEditable()
    }
    
    @objc private func doneBarButtonTapped() {
        guard let viewMode = viewMode else { return }
        
        switch viewMode {
        case .add:   
            viewModel.addWork()
        case .edit:
            viewModel.editWork()
        }
        
        self.dismiss(animated: true)
    }
    
    func configureAddMode() {
        self.viewMode = .add
        switchEditable()
        createNewWork()
    }
    
    func configureEditMode(with work: Work) {
        configure(with: work)
        createNewWork(id: work.id, state: work.state)
        self.viewMode = .edit
        self.work = work
    }
    
    private func configure(with work: Work) {
        titleTextField.text = work.title
        contentTextView.text = work.content
        deadlinePicker.date = work.deadline
    }
    
    private func switchEditable() {
        titleTextField.isEnabled = true
        contentTextView.isEditable = true
        deadlinePicker.isEnabled = true
    }
        
    private func createNewWork(id: UUID = UUID(), state: WorkState = .todo) {
        Observable.combineLatest(titleTextField.rx.text.orEmpty,
                                 contentTextView.rx.text.orEmpty,
                                 deadlinePicker.rx.date)
            .subscribe(onNext: { title, content, deadline in
                self.viewModel.createWork(id, title, content, deadline, state)
            }).disposed(by: disposeBag)
    }
}
