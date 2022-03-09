//
//  ScheduleDetailView.swift
//  ProjectManager
//
//  Created by Jae-hoon Sim on 2022/03/09.
//

import UIKit

class ScheduleDetailViewController: UIViewController {

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()

    private let titleTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()

    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        return datePicker
    }()

    private let bodyTextView: UITextField = {
        let textField = UITextField()
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

private extension ScheduleDetailViewController {
    func configure() {

    }

    func configureHierarchy() {
        self.view.addSubview(stackView)
        self.stackView.addArrangedSubview(titleTextField)
        self.stackView.addArrangedSubview(datePicker)
        self.stackView.addArrangedSubview(bodyTextView)
    }

    func configureConstraint() {
        let safeAreaLayoutGuide = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            self.stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            self.stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            self.stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            self.bodyTextView.heightAnchor.constraint(
                equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.5
            )
        ])
    }
}
