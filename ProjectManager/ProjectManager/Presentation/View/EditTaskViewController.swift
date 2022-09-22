//
//  EditTaskViewController.swift
//  ProjectManager
//
//  Created by 이예은 on 2022/09/15.
//

import UIKit

class EditTaskViewController: UIViewController, UITextFieldDelegate {
    weak var delegate: EditTaskViewControllerDelegate?
    private var viewModel: TaskViewModel?
    
    private let titleTextField: UITextField = {
       let textfield = UITextField()
        textfield.borderStyle = .roundedRect
        textfield.textAlignment = .left
        textfield.textColor = UIColor(red: 255/256, green: 183/256, blue: 195/256, alpha: 1)
        textfield.font = UIFont(name: "EF_Diary", size: 20)
        return textfield
    }()
    
    private let datePicker: UIDatePicker = {
       let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        return datePicker
    }()
    
    private let bodyTextView: UITextView = {
       let textView = UITextView()
        textView.textAlignment = .left
        textView.textColor = UIColor(red: 255/256, green: 183/256, blue: 195/256, alpha: 1)
        textView.font = UIFont(name: "EF_Diary", size: 15)
        return textView
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        configureView()
        configureUI()
        titleTextField.delegate = self
    }
    
    func configureModel(_ viewModel: TaskViewModel) {
        self.viewModel = viewModel
        
        titleTextField.text = viewModel.title
        datePicker.date = viewModel.date.toDate()
        bodyTextView.text = viewModel.body
    }
    
    private func configureNavigationBar() {
        navigationItem.title = viewModel?.state.header
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .edit,
            target: self,
            action: nil
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneButtonDidTap)
        )
    }
    
    @objc private func doneButtonDidTap() {
        guard let title = titleTextField.text,
              let body = bodyTextView.text,
              let viewModel = viewModel else {
            return
        }

        let changedViewModel = TaskViewModel.init(
            id: viewModel.id,
            title: title,
            body: body,
            date: datePicker.date,
            state: viewModel.state
        )
        delegate?.doneButtonDidTap(viewModel: viewModel, changedViewModel: changedViewModel)
        self.dismiss(animated: true)
    }
    
    private func configureView() {
        view.backgroundColor = UIColor(red: 247/256, green: 255/256, blue: 172/256, alpha: 1)
        
        [titleTextField, datePicker, bodyTextView].forEach {
            verticalStackView.addArrangedSubview($0)
        }
        view.addSubview(verticalStackView)
    }
    
    private func configureUI() {
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 10
            ),
            verticalStackView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -10
            ),
            verticalStackView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 10
            ),
            verticalStackView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -10
            )
        ])
    }
}

protocol EditTaskViewControllerDelegate: AnyObject {
    func doneButtonDidTap(viewModel: TaskViewModel, changedViewModel: TaskViewModel)
}
