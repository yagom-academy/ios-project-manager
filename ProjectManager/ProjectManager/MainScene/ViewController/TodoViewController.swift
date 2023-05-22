//
//  TodoViewController.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/18.
//

import UIKit

final class TodoViewController: UIViewController {
    
    private var viewModel = TodoViewModel()
    
    private let parentTextView = UIView()
    private let titleTextField = TodoTitleTextField()
    private let datePicker = UIDatePicker()
    private let descriptionTextView = UITextView()
    
    weak var taskDelegate: TaskDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationViewUI()
        configureViewUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        configureShadow()
    }
    
    @objc private func didTapCancelButton() {
        self.dismiss(animated: true)
    }
    
    @objc private func didTapDoneButton() {
        do {
            let task = try viewModel.makeTask(title: titleTextField.text,
                                              description: descriptionTextView.text,
                                              date: datePicker.date)
            
            taskDelegate?.saveTask(task)
            
            self.dismiss(animated: true)
        } catch(let error) {
            showErrorAlert(error)
        }
    }
}

extension TodoViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return viewModel.restrictNumberOfText(range: range, text: text)
    }
}

// MARK: UI
extension TodoViewController {
    private func showErrorAlert(_ error: Error) {
        let alertController = UIAlertController(title: error.localizedDescription,
                                                message: nil,
                                                preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "확인", style: .cancel)
        
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
    
    private func configureNavigationViewUI() {
        navigationItem.title = "TODO"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                           target: self,
                                                           action: #selector(didTapCancelButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                            target: self,
                                                            action: #selector(didTapDoneButton))
    }
    
    private func configureViewUI() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.backgroundColor = .systemGray5

        configureDatePickerUI()
        configureTextViewUI()
        
        let mainStackView = UIStackView(arrangedSubviews: [titleTextField, datePicker, parentTextView])
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.spacing = 8
        mainStackView.alignment = .center
        
        view.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            titleTextField.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 10),
            titleTextField.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -10),
            
            datePicker.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 10),
            datePicker.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -10),
            
            descriptionTextView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 10),
            descriptionTextView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -10)
        ])
    }
    
    private func configureDatePickerUI() {
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .date
        datePicker.locale = Locale.current
        datePicker.timeZone = .autoupdatingCurrent
        datePicker.preferredDatePickerStyle = .wheels
    }
    
    private func configureTextViewUI() {
        descriptionTextView.delegate = self
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.font = .preferredFont(forTextStyle: .title2)
        descriptionTextView.layer.borderColor = UIColor.label.cgColor
        descriptionTextView.layer.borderWidth = 0.3
        
        parentTextView.translatesAutoresizingMaskIntoConstraints = false
        
        parentTextView.addSubview(descriptionTextView)
        
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: parentTextView.topAnchor),
            descriptionTextView.leadingAnchor.constraint(equalTo: parentTextView.leadingAnchor),
            descriptionTextView.trailingAnchor.constraint(equalTo: parentTextView.trailingAnchor),
            descriptionTextView.bottomAnchor.constraint(equalTo: parentTextView.bottomAnchor)
        ])
    }
    
    private func configureShadow() {
        titleTextField.layer.shadowColor = UIColor.label.cgColor
        titleTextField.layer.shadowOpacity = 0.3
        titleTextField.layer.shadowOffset = CGSize(width: 0, height: 3)
        
        let textFieldShadowPath = CGPath(rect: titleTextField.bounds, transform: nil)

        titleTextField.layer.shadowPath = textFieldShadowPath
        
        parentTextView.layer.masksToBounds = false
        parentTextView.layer.shadowColor = UIColor.label.cgColor
        parentTextView.layer.shadowOpacity = 0.3
        parentTextView.layer.shadowOffset = CGSize(width: 0, height: 3)
        
        let textViewShadowPath = CGPath(rect: parentTextView.bounds, transform: nil)
        
        parentTextView.layer.shadowPath = textViewShadowPath
    }
}
