//
//  AddTaskViewController.swift
//  ProjectManager
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import UIKit
import RxSwift

fileprivate enum LocalNames {
    static let navigationTitle = "TODO"
}

final class AddTaskViewController: UIViewController {
    
    // MARK: View
    
    private var titleTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textContainerInset = .init(top: 3, left: 3, bottom: 3, right: 3)
        textView.font = .systemFont(ofSize: 20)
        return textView
    }()
    private var datePickerView: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.minimumDate = Date()
        picker.maximumDate = .distantFuture
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    private var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textContainerInset = .init(top: 3, left: 3, bottom: 3, right: 3)
        textView.font = .systemFont(ofSize: 20)
        return textView
    }()
    
    var viewmodel: AddTaskViewModel?
    let disposeBag = DisposeBag()
    
    // MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureViewLayout()
        bindViewModel()
    }
}

// MARK: Functions

extension AddTaskViewController {
    
    func bindViewModel() {
        guard let viewmodel = self.viewmodel,
              let button = navigationItem.rightBarButtonItem else { return }
        let done = button.rx.tap.asObservable()
        let title = titleTextView.rx.text.orEmpty.filter { !$0.isEmpty }.asObservable()
        let description = descriptionTextView.rx.text.orEmpty.filter { !$0.isEmpty }.asObservable()
        let date = datePickerView.rx.date.asObservable()
        let input = AddTaskViewModel.Input(doneTrigger: done,
                                           titleTrigger: title,
                                           descriptionTrigger: description,
                                           dateTrigger: date)
        let output = viewmodel.transform(input: input)
        output.createdTask
            .subscribe(onNext: { _ in
                self.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = LocalNames.navigationTitle
        self.navigationController?.navigationBar.backgroundColor = .systemGray3
        let rightButton = UIBarButtonItem(barButtonSystemItem: .done,
                                          target: self, action: #selector(dismissView))
        let leftButton = UIBarButtonItem(barButtonSystemItem: .cancel,
                                         target: self, action: #selector(dismissView))
        self.navigationItem.rightBarButtonItem = rightButton
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    @objc
    private func dismissView() {
        self.dismiss(animated: true)
    }
}

// MARK: Layout

extension AddTaskViewController {
    private func configureViewLayout() {
        view.backgroundColor = .white
        view.addSubview(titleTextView)
        view.addSubview(datePickerView)
        view.addSubview(descriptionTextView)
        
        titleTextView.backgroundColor = .systemGray6
        descriptionTextView.backgroundColor = .systemGray6
        
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
