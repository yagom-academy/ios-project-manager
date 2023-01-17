//
//  DetailViewController.swift
//  ProjectManager
//
//  Created by Kyo on 2023/01/13.
//

import UIKit

final class DetailViewController: UIViewController {
    private let detailView = DetailView()
    private let viewModel: DetailViewModel
    
    private var isEditable = false {
        didSet {
            detailView.datePicker.isEnabled = isEditable
        }
    }
    
    weak var delegate: DataSharable?
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = detailView
        setupBinding()
        detailView.titleTextField.delegate = self
        detailView.descriptionTextView.delegate = self
        setupNavigationBar()
        setupButton()
        setupDatePicker()
    }
    
    private func setupBinding() {
        viewModel.bindTitle { [weak self] title in
            self?.detailView.titleTextField.text = title
        }
        
        viewModel.bindDate { [weak self] date in
            self?.detailView.datePicker.setDate(date, animated: true)
        }
        
        viewModel.bindDescription { [weak self] description in
            self?.detailView.descriptionTextView.text = description
        }
    }
}

// MARK: - Action
extension DetailViewController {
    @objc private func doneButtonTapped() {
        guard let title = detailView.titleTextField.text else { return }
        let date = datePickerWheel(detailView.datePicker)
        
        delegate?.shareData(
            process: viewModel.fetchProcess(),
            index: viewModel.fetchIndex(),
            data: viewModel.createData(
                title: title,
                content: detailView.descriptionTextView.text,
                date: date
            )
        )
        dismiss(animated: true)
    }
    
    @objc private func editButtonTapped() {
        isEditable.toggle()
    }
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func datePickerWheel(_ sender: UIDatePicker) -> Date? {
        return sender.date
    }
}

// MARK: - UI Confuration
extension DetailViewController {
    private func setupNavigationBar() {
        title = Process.todo.titleValue
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemGray6
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setupButton() {
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneButtonTapped)
        )
        navigationItem.rightBarButtonItem = doneButton
        
        if viewModel.fetchIndex() == nil {
            let cancelButton = UIBarButtonItem(
                barButtonSystemItem: .cancel,
                target: self,
                action: #selector(cancelButtonTapped)
            )
            
            navigationItem.leftBarButtonItem = cancelButton
        } else {
            let editButton = UIBarButtonItem(
                barButtonSystemItem: .edit,
                target: self,
                action: #selector(editButtonTapped)
            )
            
            navigationItem.leftBarButtonItem = editButton
        }
    }
    
    private func setupDatePicker() {
        detailView.datePicker.preferredDatePickerStyle = .wheels
        detailView.datePicker.datePickerMode = .date
        detailView.datePicker.addTarget(
            self,
            action: #selector(datePickerWheel),
            for: .valueChanged
        )
        
        if viewModel.fetchIndex() != nil {
            detailView.datePicker.isEnabled = false
        }
    }
}

// MARK: - UITextFieldDelegate, UITextViewDelegate
extension DetailViewController: UITextFieldDelegate, UITextViewDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if viewModel.fetchIndex() == nil || isEditable { return true }
        return false
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if viewModel.fetchIndex() == nil || isEditable { return true }
        return false
    }
}
