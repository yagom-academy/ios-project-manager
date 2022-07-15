//
//  DetailViewController.swift
//  ProjectManager
//
//  Created by 김동욱 on 2022/07/08.
//
import UIKit

import RxCocoa
import RxSwift

final class DetailViewController: UIViewController {
    private let selectedTodo: Todo?
    private let todoListItemStatus: TodoListItemStatus
    private let detailViewModel: DetailViewModel
    private let disposeBag = DisposeBag()
    weak private var coordinator: AppCoordinator?
    
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemBackground
        textField.placeholder = "Title"
        textField.font = UIFont.preferredFont(forTextStyle: .title3)
        textField.setContentHuggingPriority(.required, for: .vertical)
        textField.layer.cornerRadius = 10
        textField.layer.shadowOffset = CGSize(width: 3, height: 3)
        textField.layer.shadowOpacity = 0.3
        textField.layer.shadowRadius = 5
        textField.isEnabled = self.selectedTodo == nil ? true : false
        
        return textField
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.setContentHuggingPriority(.required, for: .vertical)
        datePicker.isEnabled = self.selectedTodo == nil ? true : false
        
        return datePicker
    }()
    
    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .systemBackground
        textView.clipsToBounds = false
        textView.layer.cornerRadius = 10
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.layer.shadowOffset = CGSize(width: 3, height: 3)
        textView.layer.shadowOpacity = 0.3
        textView.layer.shadowRadius = 5
        textView.isEditable = self.selectedTodo == nil ? true : false
        
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
    
    private lazy var leftBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(
            title: self.selectedTodo == nil ? "Cancle" : "Edit",
            style: .plain,
            target: nil,
            action: nil
        )
        return barButton
    }()
    
    private let rightBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(
            title: "Done",
            style: .plain,
            target: nil,
            action: nil
        )
        return barButton
    }()
    
    init(
        selectedTodo: Todo?,
        todoListItemStatus: TodoListItemStatus,
        detailViewModel: DetailViewModel,
        coordinator: AppCoordinator
    ) {
        self.selectedTodo = selectedTodo
        self.todoListItemStatus = todoListItemStatus
        self.detailViewModel = detailViewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNavigationBar()
        self.setUpDetailStackView()
        self.setUpTitleTextField()
        self.setUpEditView()
        self.bind()
    }
    
    private func setUpNavigationBar() {
        self.navigationItem.title = self.todoListItemStatus.title
        self.navigationItem.leftBarButtonItem = self.leftBarButton
        self.navigationItem.rightBarButtonItem = self.rightBarButton
    }
    
    private func setUpDetailStackView() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(self.detailStackView)
        self.detailStackView.addArrangedSubviews(
            with: [
                self.titleTextField,
                self.datePicker,
                self.descriptionTextView
            ])
        
        NSLayoutConstraint.activate([
            self.detailStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.detailStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            self.detailStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            self.detailStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    private func setUpTitleTextField() {
        NSLayoutConstraint.activate([
            self.titleTextField.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func setUpEditView() {
        if let selectedTodo = self.selectedTodo {
            self.titleTextField.text = selectedTodo.title
            self.datePicker.date = selectedTodo.date
            self.descriptionTextView.text = selectedTodo.description
        }
    }
    
    private func bind() {
        rightBarButton.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] in
                self?.detailViewModel.doneButtonTapEvent(
                    todo: self?.createTodo(),
                    selectedTodo: self?.selectedTodo,
                    completion: { [weak self] in
                        self?.coordinator?.dismiss()
                    })
            })
            .disposed(by: self.disposeBag)
        
        leftBarButton.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] in
                self?.selectedTodo == nil ? self?.coordinator?.dismiss() : self?.changeEditable()
            })
            .disposed(by: self.disposeBag)
    }
    
    private func createTodo() -> Todo {
        if let selectedTodo = self.selectedTodo {
            return Todo(
                todoListItemStatus: selectedTodo.todoListItemStatus,
                identifier: selectedTodo.identifier,
                title: self.titleTextField.text ?? "",
                description: self.descriptionTextView.text ?? "",
                date: self.datePicker.date
            )
        }
        
        return Todo(
            todoListItemStatus: .todo,
            identifier: UUID(),
            title: self.titleTextField.text ?? "",
            description: self.descriptionTextView.text ?? "",
            date: self.datePicker.date
        )
    }
    
    private func changeEditable() {
        self.leftBarButton.title = self.leftBarButton.title == "Edit" ? "Cancle" : "Edit"
        self.titleTextField.isEnabled = !self.titleTextField.isEnabled
        self.datePicker.isEnabled = !self.datePicker.isEnabled
        self.descriptionTextView.isEditable = !self.descriptionTextView.isEditable
    }
}
