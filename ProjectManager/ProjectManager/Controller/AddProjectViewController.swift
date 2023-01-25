//
//  AddProjectViewController.swift
//  ProjectManager
//
//  Created by jin on 1/16/23.
//

import UIKit

class AddProjectViewController: UIViewController {

    enum Constant {
        static let datePickerWidth: CGFloat = 400
        static let navigationTitle = "TODO"
    }

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
        configureNavigationItem()
        configureDatePicker()
        configureContraints()
    }
    
    private func configureNavigationItem() {
        navigationItem.title = Constant.navigationTitle
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissCurrentViewController))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(saveAndDismissCurrentViewController))
    }

    private func configureDatePicker() {
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.locale = .current
        datePicker.timeZone = .current
    }

    private func configureContraints() {
        NSLayoutConstraint.activate([
            datePicker.widthAnchor.constraint(equalToConstant: Constant.datePickerWidth),
            datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            datePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    // MARK: - Selectors
    @objc private func dismissCurrentViewController() {
        self.dismiss(animated: true)
    }

    @objc private func saveAndDismissCurrentViewController() {
        self.dismissCurrentViewController()
    }
    // MARK: - Helpers
}
