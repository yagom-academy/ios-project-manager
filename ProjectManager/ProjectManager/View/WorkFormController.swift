//
//  WorkFormViewController.swift
//  ProjectManager
//
//  Created by leewonseok on 2023/01/13.
//

import UIKit

protocol WorkFormDelegate: AnyObject {
    func send(data: Work)
}

final class WorkFormViewController: UIViewController {
    var viewModel: WorkFormViewModel?
    
    weak var delegate: WorkFormDelegate?
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Title"
        textField.font = .preferredFont(forTextStyle: .title3)
        textField.backgroundColor = .systemBackground
        textField.layer.shadowOffset = CGSize(width: 0, height: 3)
        textField.layer.shadowOpacity = 0.3
        return textField
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.preferredDatePickerStyle = .wheels
        return datePicker
    }()
    
    private let bodyTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.clipsToBounds = false
        textView.backgroundColor = .systemBackground
        textView.layer.shadowOffset = CGSize(width: 0, height: 3)
        textView.layer.shadowOpacity = 0.3
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureLayout()
        configureBind()
        configureData()
        bodyTextView.delegate = self
    }
    
    private func configureBind() {
        viewModel?.bindIsEdit { [weak self] in
            self?.titleTextField.isEnabled = $0
            self?.titleTextField.textColor = $0 ? .black : .systemGray3
            self?.bodyTextView.isEditable = $0
            self?.bodyTextView.textColor = $0 ? .black : .systemGray3
            self?.datePicker.isEnabled = $0
        }
        
        viewModel?.bindWork { [weak self] work in
            self?.titleTextField.text = work?.title
            self?.bodyTextView.text = work?.body
            self?.datePicker.date = work?.endDate ?? Date()
        }
    }
    
    private func configureData() {
        viewModel?.load()
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "TODO"
        if viewModel?.work != nil {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self,
                                                               action: #selector(editButtonTapped))
        } else {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self,
                                                               action: #selector(cancelButtonTapped))
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self,
                                                            action: #selector(doneButtonTapped))
        navigationController?.navigationBar.backgroundColor = .systemGray5
    }
    
    private func configureLayout() {
        view.backgroundColor = .white
        view.addSubview(stackView)
        stackView.addArrangedSubview(titleTextField)
        stackView.addArrangedSubview(datePicker)
        stackView.addArrangedSubview(bodyTextView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            titleTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc private func editButtonTapped() {
        viewModel?.toggleEdit()
    }
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func doneButtonTapped() {
        guard let work = viewModel?.updateWork(title: titleTextField.text,
                                              body: bodyTextView.text,
                                              date: datePicker.date) else { return }
        
        delegate?.send(data: work)
        dismiss(animated: true)
    }
}

extension WorkFormViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > 1000 {
            textView.deleteBackward()
        }
    }
}
