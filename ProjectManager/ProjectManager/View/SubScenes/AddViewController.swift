//
//  AddViewController.swift
//  ProjectManager
//
//  Created by Kyo on 2023/01/13.
//

import UIKit

final class AddViewController: UIViewController {
    private let updateView = UpdateTodoView()
    private let viewModel: DataUpdatable
    private var indexPath: IndexPath?
    private var canEdit = false
    
    init() {
        viewModel = AddViewModel()
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
    }
    
    private func hasSelectedData(process: Process, indexPath: IndexPath?) {
        guard let indexPath = indexPath else { return }
        (viewModel as? DataFetchable)?.fetchSelectData(
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
extension AddViewController {
    @objc private func datePickerWheel(_ sender: UIDatePicker) -> Date? {
        return sender.date
    }
    
    @objc private func doneButtonTapped() {
        guard let title = updateView.titleTextField.text else { return }
        let date = datePickerWheel(updateView.datePicker)
        
        viewModel.updateData(
            process: .todo,
            title: title,
            content: updateView.descriptionTextView.text,
            date: date,
            indexPath: nil
        )

        dismiss(animated: true)
    }
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true)
    }
}

// MARK: - UI Confuration
extension AddViewController {
    private func setupNavigationBar() {
        title = Process.todo.titleValue
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemGray6
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        let cancelButton = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelButtonTapped)
        )
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneButtonTapped)
        )
        
        navigationItem.leftBarButtonItem = cancelButton
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
