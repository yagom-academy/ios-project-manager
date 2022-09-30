//
//  TodoDetailViewController.swift
//  ProjectManager
//
//  Created by Baek on 2022/09/21.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class TodoDetailViewController: UIViewController {
    private let pickTodo: TodoModel?
    private let todoCategory: TodoCategory
    private let todoDetailType: TodoDetailType
    weak private var coordinator: ApplyCoordinator?
    private let todoDetailViewModel: TodoDetailViewModel
    private let disposeBag = DisposeBag()
    private let emptyString = ""
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    private let todoTitle: UITextField = {
        let textField =  UITextField()
        textField.placeholder = TodoDetailButtonType.title
        textField.font = UIFont.preferredFont(forTextStyle: .title2)
        textField.backgroundColor = .systemBackground
        textField.layer.shadowOffset = CGSize(width: 5, height: 5)
        textField.layer.shadowOpacity = 0.5
        textField.layer.shadowRadius = 5
        return textField
    }()
    
    private let todoDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.locale = .autoupdatingCurrent
        datePicker.preferredDatePickerStyle = .wheels
        return datePicker
    }()
    
    private let todoDescription: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.clipsToBounds = false
        textView.backgroundColor = .systemBackground
        textView.layer.cornerRadius = 10
        textView.layer.shadowOffset = CGSize(width: 5, height: 5)
        textView.layer.shadowOpacity = 0.5
        textView.layer.shadowRadius = 5
        return textView
    }()
    
    private let leftBarButton = UIBarButtonItem( title: TodoDetailButtonType.edit, style: .plain, target: nil, action: nil)
    
    private let rightBarButton = UIBarButtonItem( title: TodoDetailButtonType.done, style: .plain, target: nil, action: nil)
    
    init(pickTodo: TodoModel?, todoCategory: TodoCategory, todoDetailType: TodoDetailType, todoDetailViewModel: TodoDetailViewModel, coordinator: ApplyCoordinator) {
        self.pickTodo = pickTodo
        self.todoCategory = todoCategory
        self.todoDetailType = todoDetailType
        self.coordinator = coordinator
        self.todoDetailViewModel = todoDetailViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addNavigationBar()
        self.addTodoDetailStackView()
        self.setupConstraint()
        self.fetchLeftNavigationBarButtonTitle()
        self.prepareTodoUI()
        self.bind()
    }
    
    private func addNavigationBar() {
        self.navigationItem.title = self.todoCategory.rawValue
        self.navigationItem.leftBarButtonItem = self.leftBarButton
        self.navigationItem.rightBarButtonItem = self.rightBarButton
    }
    
    private func fetchLeftNavigationBarButtonTitle() {
        self.leftBarButton.title = self.todoDetailType == .newTodo ? TodoDetailButtonType.cancel : TodoDetailButtonType.edit
    }
    
    private func addTodoDetailStackView() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(self.verticalStackView)
        self.verticalStackView.addArrangedSubview(self.todoTitle)
        self.verticalStackView.addArrangedSubview(self.todoDatePicker)
        self.verticalStackView.addArrangedSubview(self.todoDescription)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            self.verticalStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            self.verticalStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.verticalStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            self.verticalStackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10),
            
            self.todoTitle.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func bind() {
        rightBarButton.rx.tap.asObservable()
            .subscribe({ result in
                switch result {
                case .next:
                    self.todoDetailViewModel.doneButtonClick(todo: self.createTodoContents(), todoDetailType: self.todoDetailType)
                    self.coordinator?.dismissView()
                    
                case let .error(err):
                    print(err.localizedDescription)
                    
                case .completed:
                    break
                }
            })
            .disposed(by: self.disposeBag)
        
        leftBarButton.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] in
                if self?.todoDetailType == .newTodo {
                    self?.coordinator?.dismissView()
                } else {
                    self?.changeTodoContents()
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func createTodoContents() -> TodoModel {
        if let pickTodoModel = self.pickTodo {
            return TodoModel(id: pickTodoModel.id, category: pickTodoModel.category, title: self.todoTitle.text ?? emptyString, body: self.todoDescription.text ?? emptyString, createdAt: self.todoDatePicker.date)
           
        }
        return TodoModel(id: UUID(), category: .todo, title: self.todoTitle.text ?? emptyString, body: self.todoDescription.text ?? emptyString, createdAt: self.todoDatePicker.date)
    }
    
    private func prepareTodoUI() {
        if self.todoDetailType == .newTodo {
            self.todoTitle.isEnabled = true
            self.todoDatePicker.isEnabled = true
            self.todoDescription.isEditable = true
        } else {
            self.todoTitle.isEnabled = false
            self.todoDatePicker.isEnabled = false
            self.todoDescription.isEditable = false
        }
    }
    
    private func changeTodoContents() {
        self.leftBarButton.title = self.leftBarButton.title == TodoDetailButtonType.cancel ? TodoDetailButtonType.cancel: TodoDetailButtonType.edit
        self.todoTitle.isEnabled = !self.todoTitle.isEnabled
        self.todoDatePicker.isEnabled = !self.todoDatePicker.isEnabled
        self.todoDescription.isEditable = !self.todoDescription.isEditable
    }
}
