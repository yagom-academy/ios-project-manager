//
//  EditTaskViewController.swift
//  ProjectManager
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit
import RxSwift

fileprivate enum Titles {
    static let navigationItem = "TODO"
}

final class EditTaskViewController: UIViewController {
    
    // MARK: Subview
    
    private var titleTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .systemFont(ofSize: 20)
        textView.isEditable = false
        
        return textView
    }()
    private var datePickerView: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.minimumDate = Date()
        picker.maximumDate = .distantFuture
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.isEnabled = false
        
        return picker
    }()
    private var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .systemFont(ofSize: 20)
        textView.isEditable = false
        
        return textView
    }()
    
    var viewModel: EditTaskViewModel?
    private let disposeBag = DisposeBag()
    
    // MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        combineViews()
        configureViewLayout()
        bindViewModel()
    }
}

// MARK: Functions
extension EditTaskViewController {
    
    func bindViewModel() {
        guard let viewModel = self.viewModel,
              let doneButton = navigationItem.rightBarButtonItem,
              let editButton = navigationItem.leftBarButtonItem
        else {
            return
        }
        
        let initialSetUpTrigger = self.rx
            .methodInvoked(#selector(viewWillAppear))
            .map { _ in }
        let editTrigger = editButton.rx.tap.asObservable()
        let doneTrigger = doneButton.rx.tap.asObservable()
        let title = titleTextView.rx.text
            .orEmpty
            .filter { !$0.isEmpty }
            .asObservable()
        let description = descriptionTextView.rx.text
            .orEmpty
            .filter { !$0.isEmpty }
            .asObservable()
        let date = datePickerView.rx.date.asObservable()
        
        let input = EditTaskViewModel.Input(
            initialSetUpTrigger: initialSetUpTrigger,
            editTrigger: editTrigger, doneTrigger: doneTrigger,
            titleTrigger: title, descriptionTrigger: description,
            dateTrigger: date
        )
        let output = viewModel.transform(input: input)
        
        output.initialSetUpData
            .subscribe(
                onNext: { initialData in
                    self.titleTextView.text = initialData.title
                    self.datePickerView.date = initialData.date
                    self.descriptionTextView.text = initialData.description
                }
            )
            .disposed(by: disposeBag)
        
        output.canEdit
            .subscribe(
                onNext: { _ in
                    self.toggleEditability()
                }
            )
            .disposed(by: disposeBag)
        
        output.editedTask
            .subscribe(
                onNext: { _ in
                    self.dismissView()
                }
            )
            .disposed(by: disposeBag)
    }
    
    private func toggleEditability() {
        titleTextView.isEditable.toggle()
        datePickerView.isEnabled.toggle()
        descriptionTextView.isEditable.toggle()
        
        switch titleTextView.isEditable {
        case true:
            titleTextView.backgroundColor = .systemGray6
            descriptionTextView.backgroundColor = .systemGray6
        case false:
            titleTextView.backgroundColor = .white
            descriptionTextView.backgroundColor = .white
        }
    }
    
    private func configureNavigationBar() {
        navigationItem.title = Titles.navigationItem
        navigationController?.navigationBar.backgroundColor = .systemGray3
        let rightButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: nil
        )
        let leftButton = UIBarButtonItem(
            barButtonSystemItem: .edit,
            target: self,
            action: nil
        )
        navigationItem.rightBarButtonItem = rightButton
        navigationItem.leftBarButtonItem = leftButton
    }
    
    private func dismissView() {
        dismiss(animated: true)
    }
}

// MARK: Layout
extension EditTaskViewController {
    
    private func combineViews() {
        view.backgroundColor = .white
        view.addSubview(titleTextView)
        view.addSubview(datePickerView)
        view.addSubview(descriptionTextView)
    }
    
    private func configureViewLayout() {
        
        NSLayoutConstraint.activate([
            titleTextView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 10
            ),
            titleTextView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 10
            ),
            titleTextView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -10
            ),
            titleTextView.heightAnchor.constraint(
                equalToConstant: 80
            ),
        ])
        
        NSLayoutConstraint.activate([
            datePickerView.topAnchor.constraint(
                equalTo: titleTextView.bottomAnchor,
                constant: 10
            ),
            datePickerView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 10
            ),
            datePickerView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -10
            ),
            datePickerView.heightAnchor.constraint(
                equalToConstant: 180
            ),
        ])
        
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(
                equalTo: datePickerView.bottomAnchor,
                constant: 10
            ),
            descriptionTextView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 10
            ),
            descriptionTextView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -10
            ),
            descriptionTextView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: -10
            ),
        ])
    }
}
