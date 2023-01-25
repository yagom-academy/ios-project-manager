//
//  AddProjectViewController.swift
//  ProjectManager
//
//  Created by jin on 1/16/23.
//

import UIKit

class AddProjectViewController: UIViewController {

    // MARK: - Properties
    private let datePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
    }

    // MARK: - UI
    private func configureUI() {
        view.addSubview(datePicker)
        configureDatePicker()
        configureContraints()
    }

    private func configureDatePicker() {
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.locale = .current
        datePicker.timeZone = .current
        datePicker.addTarget(self, action: #selector(handleDatePicker(_:)), for: .valueChanged)
    }

    private func configureContraints() {
        NSLayoutConstraint.activate([
            datePicker.widthAnchor.constraint(equalToConstant: 400),
            datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            datePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    // MARK: - Selectors
    @objc
    private func handleDatePicker(_ sender: UIDatePicker) {
        print("Sender: "+sender.date.description)
        print(Date())
    }
    // MARK: - Helpers
}
