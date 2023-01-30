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

final class UpdateTaskViewController: UIViewController {
    var viewModel: UpdateTaskViewModel?
    private let disposeBag = DisposeBag()
    
    // MARK: View(s)
    
    private let titleTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .systemFont(ofSize: 20)
        
        return textView
    }()
    private let datePickerView: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.minimumDate = Date()
        picker.maximumDate = .distantFuture
        picker.translatesAutoresizingMaskIntoConstraints = false
        
        return picker
    }()
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .systemFont(ofSize: 20)
        
        return textView
    }()
    
    // MARK: Override(s)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let operationType = self.viewModel?.operationType else { return }
        setEditability(by: operationType)
        configureNavigationBar(by: operationType)
        bindViewModel()
        combineViews()
        configureViewLayout()
    }
    
    // MARK: Function(s)
    
    func setEditability(by operationType: TaskOperationType) {
        if operationType == .edit {
            titleTextView.isEditable = false
            datePickerView.isEnabled = false
            descriptionTextView.isEditable = false
            
            titleTextView.backgroundColor = .white
            descriptionTextView.backgroundColor = .white
            
            return
        }
        
        titleTextView.backgroundColor = .systemGray6
        descriptionTextView.backgroundColor = .systemGray6
    }
    
    func bindViewModel() {
        guard let viewModel = self.viewModel,
              let button = navigationItem.rightBarButtonItem
        else {
            return
        }
        
        let initialSetUpTrigger = self.rx
            .methodInvoked(#selector(viewWillAppear))
            .map { _ in }
            .asObservable()
        let done = button.rx.tap
            .asObservable()
        let title = titleTextView.rx.text
            .orEmpty
            .filter { !$0.isEmpty }
            .asObservable()
        let description = descriptionTextView.rx.text
            .orEmpty
            .filter { !$0.isEmpty }
            .asObservable()
        let date = datePickerView.rx.date
            .asObservable()
        
        let input = UpdateTaskViewModel.Input(
            initialSetUpTrigger: initialSetUpTrigger,
            doneTrigger: done,
            titleTrigger: title,
            descriptionTrigger: description,
            dateTrigger: date
        )
        let output = viewModel.transform(input: input)
        
        output.formedTask
            .subscribe(onNext: { _ in
                self.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
        
        output.initialSetUpData
            .subscribe(onNext: { data in
                self.titleTextView.text = data.title
                self.descriptionTextView.text = data.description
                self.datePickerView.date = data.date
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: Private Function(s)
    
    private func configureNavigationBar(by operationType: TaskOperationType) {
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: nil
        )
        let cancelButton = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(dismissView)
        )
        let editButton = UIBarButtonItem(
            barButtonSystemItem: .edit,
            target: self,
            action: #selector(toggleEditability)
        )
        
        switch operationType {
        case .add:
            navigationItem.leftBarButtonItem = cancelButton
        case .edit:
            navigationItem.leftBarButtonItem = editButton
        }
        
        navigationItem.rightBarButtonItem = doneButton
        navigationItem.title = Titles.navigationItem
        navigationController?.navigationBar.backgroundColor = .systemGray3
    }
    
    @objc
    private func dismissView() {
        dismiss(animated: true)
    }
    
    @objc
    private func toggleEditability() {
        titleTextView.isEditable.toggle()
        datePickerView.isEnabled.toggle()
        descriptionTextView.isEditable.toggle()
        
        switchBackgroundColorByEditability()
    }
    
    private func switchBackgroundColorByEditability() {
        switch titleTextView.isEditable {
        case true:
            titleTextView.backgroundColor = .systemGray6
            descriptionTextView.backgroundColor = .systemGray6
        case false:
            titleTextView.backgroundColor = .white
            descriptionTextView.backgroundColor = .white
        }
    }
    
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
