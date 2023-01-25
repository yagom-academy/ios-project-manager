//
//  EditTaskViewController.swift
//  ProjectManager
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit
import RxSwift

fileprivate enum Common {
    static let navigationTitle = "TODO"
}

final class EditTaskViewController: UIViewController {
    
    // MARK: Subview
    
    private var titleTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
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
        textView.isEditable = false
        return textView
    }()
    
    var viewModel: EditTaskViewModel?
    let disposeBag = DisposeBag()
    
    // MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureViewLayout()
        insertData()
        bind()
    }
}

// MARK: Functions
extension EditTaskViewController {
    
    func insertData() {
        guard let viewModel = self.viewModel else { return }
        self.titleTextView.text = viewModel.title
        self.datePickerView.date = viewModel.date
        self.descriptionTextView.text = viewModel.description
    }
    
    func bind() {
        guard let viewModel = self.viewModel,
              let doneButton = navigationItem.rightBarButtonItem,
              let editButton = navigationItem.leftBarButtonItem
        else { return }
        
        let editTrigger = editButton.rx
            .tap
            .asObservable()
        let doneTrigger = doneButton.rx
            .tap
            .asObservable()
        let title = titleTextView.rx
            .text
            .orEmpty
            .filter { !$0.isEmpty }
            .asObservable()
        let description = descriptionTextView.rx
            .text
            .orEmpty.filter { !$0.isEmpty }
            .asObservable()
        let date = datePickerView.rx
            .date
            .asObservable()
        
        let input = EditTaskViewModel.Input(editTrigger: editTrigger, doneTrigger: doneTrigger,
                                            titleTrigger: title, descriptionTrigger: description,
                                            dateTrigger: date)
        let output = viewModel.transform(input: input)
        
        output.canEdit
            .subscribe(onNext: { _ in
                self.toggleEditability()
            })
            .disposed(by: disposeBag)
        
        output.editedTask
            .subscribe(onNext: { _ in
                self.dismissView()
            })
            .disposed(by: disposeBag)
    }
    
    private func toggleEditability() {
        self.titleTextView.isEditable.toggle()
        self.datePickerView.isEnabled.toggle()
        self.descriptionTextView.isEditable.toggle()
        
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
        self.navigationItem.title = Common.navigationTitle
        self.navigationController?.navigationBar.backgroundColor = .systemGray3
        let rightButton = UIBarButtonItem(barButtonSystemItem: .done,
                                          target: self, action: nil)
        let leftButton = UIBarButtonItem(barButtonSystemItem: .edit,
                                         target: self, action: nil)
        self.navigationItem.rightBarButtonItem = rightButton
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    private func dismissView() {
        self.dismiss(animated: true)
    }
}

// MARK: Layout
extension EditTaskViewController {
    private func configureViewLayout() {
        view.backgroundColor = .white
        view.addSubview(titleTextView)
        view.addSubview(datePickerView)
        view.addSubview(descriptionTextView)
        
        NSLayoutConstraint.activate([
            titleTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                               constant: 10),
            titleTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                   constant: 10),
            titleTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                    constant: -10),
            titleTextView.heightAnchor.constraint(equalToConstant: 80),
            
            datePickerView.topAnchor.constraint(equalTo: titleTextView.bottomAnchor,
                                                constant: 10),
            datePickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                    constant: 10),
            datePickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                     constant: -10),
            datePickerView.heightAnchor.constraint(equalToConstant: 180),
            
            descriptionTextView.topAnchor.constraint(equalTo: datePickerView.bottomAnchor,
                                                     constant: 10),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                         constant: 10),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                          constant: -10),
            descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                        constant: -10),
        ])
    }
}
