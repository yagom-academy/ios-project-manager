//
//  DetailViewController.swift
//  ProjectManager
//
//  Created by 김동욱 on 2022/07/08.
//
import UIKit

import RxCocoa
import RxSwift

private enum Const {
    static let title = "Title"
    static let cancel = "Cancel"
    static let done = "Done"
    static let edit = "Edit"
    static let empty = ""
}

final class DetailViewController: UIViewController {
    private let selectedTodo: Todo?
    private let todoListItemStatus: TodoListItemStatus
    private let detailViewModel: DetailViewModel
    private let disposeBag = DisposeBag()
    weak private var coordinator: AppCoordinator?
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemBackground
        textField.placeholder = Const.title
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
    
    private let leftBarButton = UIBarButtonItem(
        title: Const.cancel,
        style: .plain,
        target: nil,
        action: nil
    )
    
    private let rightBarButton = UIBarButtonItem(
        title: Const.done,
        style: .plain,
        target: nil,
        action: nil
    )
    
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
        self.setUpAttribute()
        self.setUpEditView()
        self.bind()
    }
    
    private func setUpNavigationBar() {
        self.navigationItem.title = self.todoListItemStatus.displayName
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
    
    private func setUpAttribute() {
        self.titleTextField.isEnabled = self.selectedTodo == nil ? true : false
        self.datePicker.isEnabled = self.selectedTodo == nil ? true : false
        self.descriptionTextView.isEditable = self.selectedTodo == nil ? true : false
        self.leftBarButton.title = self.selectedTodo == nil ? Const.cancel : Const.edit
    }
    
    private func setUpEditView() {
        if let selectedTodo = self.selectedTodo {
            self.titleTextField.text = selectedTodo.title
            self.datePicker.date = selectedTodo.date
            self.descriptionTextView.text = selectedTodo.description
        }
    }
    
    private func bind() {
        rightBarButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.detailViewModel.doneButtonTapEvent(
                    todo: self?.createTodo(),
                    selectedTodo: self?.selectedTodo,
                    completion: { [weak self] in
                        self?.coordinator?.dismiss()
                    })
            })
            .disposed(by: self.disposeBag)
        
        leftBarButton.rx.tap
            .subscribe(onNext: { [weak self] in
                if self?.selectedTodo == nil {
                    self?.coordinator?.dismiss()
                } else {
                    self?.changeAttribute()
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    private func createTodo() -> Todo {
        if let selectedTodo = self.selectedTodo {
            return Todo(
                todoListItemStatus: selectedTodo.todoListItemStatus,
                identifier: selectedTodo.identifier,
                title: self.titleTextField.text ?? Const.empty,
                description: self.descriptionTextView.text ?? Const.empty,
                date: self.datePicker.date
            )
        }
        
        return Todo(
            todoListItemStatus: .todo,
            title: self.titleTextField.text ?? Const.empty,
            description: self.descriptionTextView.text ?? Const.empty,
            date: self.datePicker.date
        )
    }
    
    private func changeAttribute() {
        self.leftBarButton.title = self.leftBarButton.title == Const.edit ? Const.cancel : Const.edit
        self.titleTextField.isEnabled = !self.titleTextField.isEnabled
        self.datePicker.isEnabled = !self.datePicker.isEnabled
        self.descriptionTextView.isEditable = !self.descriptionTextView.isEditable
    }
}
