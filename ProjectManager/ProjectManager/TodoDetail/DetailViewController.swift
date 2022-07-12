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
    private let detailViewType: DetailViewType
    private let todoListItemStatus: TodoListItemStatus
    private let detailViewModel: DetailViewModel
    private let disposeBag = DisposeBag()
    weak private var coordinator: MainCoordinator?

    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemBackground
        textField.placeholder = "Title"
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
    
    private var leftBarButtonTitle: String {
        return self.detailViewType == .create ? "Cancel" : "Edit"
    }
    
    init(
        detailViewType: DetailViewType,
        todoListItemStatus: TodoListItemStatus,
        detailViewModel: DetailViewModel,
        coordinator: MainCoordinator
    ) {
        self.detailViewType = detailViewType
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
        self.bind()
    }
    
    private func setUpNavigationBar() {
        self.navigationItem.title = self.todoListItemStatus.title
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: self.leftBarButtonTitle,
            style: .plain,
            target: nil,
            action: nil
        )
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Done",
            style: .plain,
            target: nil,
            action: nil
        )
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
    
    private func bind() {
        guard let rightBarButton = self.navigationItem.rightBarButtonItem else {
            return
        }
        
        let input = DetailViewModel.Input(
            doneButtonTapEvent: rightBarButton.rx.tap.map({ [weak self] _ in
            Todo(
                status: .todo,
                title: self?.titleTextField.text ?? "",
                description: self?.descriptionTextView.text ?? "",
                date: self?.datePicker.date ?? Formatter.fetch()
            )
        }))
            
        let output = self.detailViewModel.transform(input: input)
        
        output.dismiss
            .drive(onNext: {
                self.coordinator?.dismiss()
            })
            .disposed(by: self.disposeBag)
    }
}
