//
//  EditViewController.swift
//  ProjectManager
//
//  Created by parkhyo on 2023/01/15.
//

import UIKit

class EditViewController: UIViewController {
    private let updateView = UpdateTodoView()
    private let viewModel: SelectedDataFetchable
    private var indexPath: IndexPath?
    private var process: Process
    private var canEdit = false
    
    init(process: Process, indexPath: IndexPath) {
        viewModel = EditViewModel()
        self.process = process
        self.indexPath = indexPath
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = updateView
        setupNavigationBar()
        setupDatePicker()
        hasSelectedData(process: process, indexPath: indexPath)
    }
    
    private func hasSelectedData(process: Process, indexPath: IndexPath?) {
        guard let indexPath = indexPath else {
            print("asd")
            return }
        viewModel.fetchSelectData(
            process: process,
            indexPath: indexPath,
            completion: { data in
                
            updateView.titleTextField.text = data.title
            updateView.descriptionTextView.text = data.content
            guard let date = data.deadLine else { return }
            updateView.datePicker.setDate(date, animated: true)
        })
    }
}

// MARK: - Action
extension EditViewController {
    @objc private func datePickerWheel(_ sender: UIDatePicker) -> Date? {
        return sender.date
    }
    
    @objc private func editButtonTapped() {
        
    }
    
    @objc private func doneButtonTapped() {
        guard let title = updateView.titleTextField.text else { return }
        let date = datePickerWheel(updateView.datePicker)
        
        viewModel.updateData(
            process: .todo,
            title: title,
            content: updateView.descriptionTextView.text,
            date: date,
            indexPath: indexPath
        )

        dismiss(animated: true)
    }
}

// MARK: - UI Confuration
extension EditViewController {
    private func setupNavigationBar() {
        title = process.titleValue
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemGray6
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        let editButton = UIBarButtonItem(
            barButtonSystemItem: .edit,
            target: self,
            action: #selector(editButtonTapped)
        )
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneButtonTapped)
        )
        
        navigationItem.leftBarButtonItem = editButton
        navigationItem.rightBarButtonItem = doneButton
    }
    
    private func setupDatePicker() {
        updateView.datePicker.preferredDatePickerStyle = .wheels
        updateView.datePicker.datePickerMode = .date
        updateView.datePicker.addTarget(
            self,
            action: #selector(datePickerWheel),
            for: .valueChanged
        )
    }
}
