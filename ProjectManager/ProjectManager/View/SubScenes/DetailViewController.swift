//
//  DetailViewController.swift
//  ProjectManager
//
//  Created by Kyo on 2023/01/13.
//

import UIKit

final class DetailViewController: UIViewController {
    weak var delegate: DataSharable?
    
    private let updateView = UpdateTodoView()
    private let viewModel: DetailViewModel
    private var isEditable = false
    
    init(viewModel: DetailViewModel, index: Int? = nil) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = updateView
        setupBinding()
        setupNavigationBar()
        setupDatePicker()
    }
    
    private func setupBinding() {
        viewModel.bindDetailData { [weak self] data in
            guard let data = data else { return }
            self?.updateView.titleTextField.text = data.title
            self?.updateView.descriptionTextView.text = data.content
            if let date = data.deadLine {
                self?.updateView.datePicker.setDate(date, animated: true)
            }
        }
    }
}

// MARK: - Action
extension DetailViewController {
    @objc private func datePickerWheel(_ sender: UIDatePicker) -> Date? {
        return sender.date
    }
    
    @objc private func doneButtonTapped() {
        guard let title = updateView.titleTextField.text else { return }
        let date = datePickerWheel(updateView.datePicker)
        
        delegate?.shareData(
            process: viewModel.fetchDataProcess(),
            title: title,
            content: updateView.descriptionTextView.text,
            date: date,
            index: viewModel.fetchDataIndex()
        )
        dismiss(animated: true)
    }
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true)
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
