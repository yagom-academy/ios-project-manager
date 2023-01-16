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
    private let index: Int?
    
    private var isEditable = false {
        didSet {
            detailView.datePicker.isEnabled = isEditable
        }
    }
    
    weak var delegate: DataSharable?
    
    init(viewModel: DetailViewModel, index: Int? = nil) {
        self.viewModel = viewModel
        self.index = index
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
        viewModel.bindDetailData { [weak self] data in
            guard let data = data else { return }
            self?.detailView.titleTextField.text = data.title
            self?.detailView.descriptionTextView.text = data.content
            if let date = data.deadLine {
                self?.detailView.datePicker.setDate(date, animated: true)
            }
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
            index: index,
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
        
        if index == nil {
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
        
        if index != nil {
            detailView.datePicker.isEnabled = false
        }
    }
}

// MARK: - UITextFieldDelegate, UITextViewDelegate
extension DetailViewController: UITextFieldDelegate, UITextViewDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if index == nil || isEditable { return true }
        return false
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if index == nil || isEditable { return true }
        return false
    }
}
