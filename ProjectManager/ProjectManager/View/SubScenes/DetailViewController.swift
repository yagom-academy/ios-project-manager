//
//  DetailViewController.swift
//  ProjectManager
//
//  Created by Kyo on 2023/01/13.
//

import UIKit

final class DetailViewController: UIViewController {
    weak var delegate: DataSharable?
    
    private let detailView = DetailView()
    private let viewModel: DetailViewModel
    private let process: Process
    private let index: Int?
    
    private var isEditable = false
    
    init(viewModel: DetailViewModel, process: Process, index: Int? = nil) {
        self.viewModel = viewModel
        self.process = process
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
        setupNavigationBar()
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
    @objc private func datePickerWheel(_ sender: UIDatePicker) -> Date? {
        return sender.date
    }
    
    @objc private func doneButtonTapped() {
        guard let title = detailView.titleTextField.text else { return }
        let date = datePickerWheel(detailView.datePicker)
        
        delegate?.shareData(
            process: process,
            index: index,
            data: viewModel.createData(
                title: title,
                content: detailView.descriptionTextView.text,
                date: date
            )
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
        detailView.datePicker.preferredDatePickerStyle = .wheels
        detailView.datePicker.datePickerMode = .date
        detailView.datePicker.addTarget(
            self,
            action: #selector(datePickerWheel),
            for: .valueChanged
        )
    }
}
