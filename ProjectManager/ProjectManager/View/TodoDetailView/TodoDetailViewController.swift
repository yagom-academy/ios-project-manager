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
    
    private var viewModel: ProjectManagerViewModel?
    
    private var disposeBag = DisposeBag()
    private var todoData: Observable<Todo>? {
        didSet {
            configureObservable()
        }
    }
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        let leftPaddingView = UIView(frame: CGRect(
            x: 0,
            y: 0,
            width: 30,
            height: 0
        ))
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
        textView.textContainerInset = UIEdgeInsets(
            top: 15,
            left: 15,
            bottom: 15,
            right: 15
        )
        textView.keyboardDismissMode = .interactive
        textView.alwaysBounceVertical = true
        
        return textView
    }()
    
    private lazy var bodyTextShadowView: UIView = {
        let view = UIView(frame: bodyTextView.frame)
        view.backgroundColor = .brown
        return view
    }()
    
    private let mainStackView: UIStackView = {
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
        configureShadow(bodyTextShadowView)
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
            target: nil,
            action: nil
        )
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: nil,
            action: nil
        )
        
        configureBarbuttonItems(doneButton, cancelButton)
        
        navigationItem.setLeftBarButton(cancelButton, animated: true)
        navigationItem.setRightBarButton(doneButton, animated: true)
    }
    
    private func getCurrentTodoInfomation() -> Todo? {
        guard let title = self.titleTextField.text,
              let body = self.bodyTextView.text else { return nil }
        let date = self.datePicker.date
        
        var todoId = UUID()
        var status = TodoStatus.todo
        var isOutdated = false
        
        if let todoData = self.todoData {
            todoData
                .take(1)
                .subscribe(onNext: {
                    todoId = $0.todoId
                    status = $0.status
                    isOutdated = $0.isOutdated
                })
                .disposed(by: self.disposeBag)
        }
        
        let currentTodoInfomation = Todo(
            todoId: todoId,
            title: title,
            body: body,
            createdAt: date,
            status: status,
            isOutdated: isOutdated
        )
        
        return currentTodoInfomation
    }
    
    private func configureBarbuttonItems(_ doneButton: UIBarButtonItem, _ cancelButton: UIBarButtonItem) {
        doneButton.rx.tap
            .subscribe(onNext: {
                guard let currentTodoInfo = self.getCurrentTodoInfomation() else { return }

                self.viewModel?.saveTodoData?.onNext(currentTodoInfo)
                self.viewModel?.saveTodoData?.subscribe(onCompleted: {
                    self.dismiss(animated: true)
                })
                .disposed(by: self.disposeBag)
            })
            .disposed(by: disposeBag)
        
        cancelButton.rx.tap
            .subscribe(onNext: {
                self.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func configureBackgroundColor() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureHierarchy() {
        view.addSubview(bodyTextShadowView)
        view.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(titleTextField)
        mainStackView.addArrangedSubview(datePicker)
        mainStackView.addArrangedSubview(bodyTextView)
    }
    
    private func configureLayout() {
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 20
            ),
            mainStackView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -20
            ),
            mainStackView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 20
            ),
            mainStackView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -20
            )
        ])
        
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleTextField.heightAnchor.constraint(
                equalTo: datePicker.heightAnchor,
                multiplier: 0.2
            )
        ])
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePicker.heightAnchor.constraint(
                equalTo: view.heightAnchor,
                multiplier: 0.3
            )
        ])
        
        bodyTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bodyTextView.heightAnchor.constraint(
                equalTo: view.heightAnchor,
                multiplier: 0.5
            )
        ])
        
        bodyTextShadowView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bodyTextShadowView.topAnchor.constraint(equalTo: bodyTextView.topAnchor),
            bodyTextShadowView.bottomAnchor.constraint(equalTo: bodyTextView.bottomAnchor),
            bodyTextShadowView.leadingAnchor.constraint(equalTo: bodyTextView.leadingAnchor),
            bodyTextShadowView.trailingAnchor.constraint(equalTo: bodyTextView.trailingAnchor)
        ])
    }
    
    private func configureShadow(_ view: UIView) {
        view.backgroundColor = .white

        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.systemGray6.cgColor

        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 3.0
        view.layer.shadowOffset = CGSize(
            width: 3,
            height: 3
        )
        view.layer.shadowColor = UIColor.gray.cgColor
    }
    
    private func configureObservable() {
        todoData?
            .map { $0.title }
            .bind(to: titleTextField.rx.text)
            .disposed(by: disposeBag)
        
        todoData?
            .map { $0.body }
            .bind(to: bodyTextView.rx.text)
            .disposed(by: disposeBag)
        
        todoData?
            .map { $0.createdAt }
            .bind(to: datePicker.rx.date)
            .disposed(by: disposeBag)
    }
}

// MARK: - Setter Methods

extension TodoDetailViewController {
    func set(todo todoData: Observable<Todo>?, viewModel: ProjectManagerViewModel?) {
        self.todoData = todoData
        self.viewModel = viewModel
    }
}
