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
    
    weak var delegate: DataManageable?
    
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
        setupDelegate()
        setupNavigationBar()
        setupButton()
        setupDatePicker()
    }
    
    private func setupDelegate() {
        detailView.titleTextField.delegate = self
        detailView.contentTextView.delegate = self
    }
    
    private func setupBinding() {
        viewModel.bindTitle { [weak self] title in
            self?.detailView.titleTextField.text = title
        }
        
        viewModel.bindDate { [weak self] date in
            self?.detailView.datePicker.setDate(date, animated: true)
        }
        
        viewModel.bindContent { [weak self] content in
            self?.detailView.contentTextView.text = content
        }
        
        viewModel.bindEditable { [weak self] editable in
            self?.detailView.datePicker.isEnabled = editable
        }
        
        viewModel.bindFinishEvent { [weak self] in
            self?.dismiss(animated: true)
        }
    }
}

// MARK: - Action
extension DetailViewController {
    @objc private func doneButtonTapped() {
        guard let title = detailView.titleTextField.text else { return }
        let date = datePickerWheel(detailView.datePicker)
        
        delegate?.shareData(
            viewModel.createData(
                title: title,
                content: detailView.contentTextView.text,
                date: date
            ),
            process: viewModel.process,
            index: viewModel.index
        )
        
        viewModel.finishEdit()
    }
    
    @objc private func editButtonTapped() {
        viewModel.editToggle()
    }
    
    @objc private func cancelButtonTapped() {
        viewModel.finishEdit()
    }
    
    @objc private func datePickerWheel(_ sender: UIDatePicker) -> Date? {
        return sender.date
    }
}

// MARK: - UI Confuration
extension DetailViewController {
    private func setupNavigationBar() {
        title = "\(Process.todo)"
        
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
        
        if viewModel.isNewMode() {
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
        
        if !viewModel.isNewMode() {
            detailView.datePicker.isEnabled = false
        }
    }
}

// MARK: - UITextFieldDelegate, UITextViewDelegate
extension DetailViewController: UITextFieldDelegate, UITextViewDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return viewModel.isEdiatable
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return viewModel.isEdiatable
    }
}
