//
//  ToDoDetailViewController.swift
//  ProjectManager
//
//  Created by 로빈솜 on 2023/01/11.
//

import UIKit

class ToDoDetailViewController: UIViewController {
    private let navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        return navigationBar
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let titleTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.systemGray5.cgColor
        textView.layer.shadowColor = UIColor.systemGray.cgColor
        textView.layer.shadowOffset = CGSize(width: 3, height: 5)
        textView.layer.shadowOpacity = 0.5
        textView.layer.shadowRadius = 3.0
        textView.layer.masksToBounds = false
        textView.isScrollEnabled = false
        textView.font = UIFont.preferredFont(forTextStyle: .title1)
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return textView
    }()

    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.backgroundColor = .white
        return datePicker
    }()

    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.systemGray5.cgColor
        textView.layer.shadowColor = UIColor.systemGray.cgColor
        textView.layer.shadowOffset = CGSize(width: 3, height: 5)
        textView.layer.shadowOpacity = 0.5
        textView.layer.shadowRadius = 3.0
        textView.layer.masksToBounds = false
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return textView
    }()

    override func loadView() {
        view = UIView(frame: .zero)
        view.backgroundColor = .systemBackground
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        configurePlusButton()
    }

    private func configurePlusButton() {
        let navigationItem = UINavigationItem(title: "TODO")

        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(tappedCancel(sender:)))
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(tappedDone(sender:)))

        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = doneButton

        navigationBar.setItems([navigationItem], animated: true)
    }

    @objc private func tappedCancel(sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    @objc private func tappedDone(sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    private func configureLayout() {
        view.addSubview(navigationBar)
        view.addSubview(stackView)
        stackView.addArrangedSubview(titleTextView)
        stackView.addArrangedSubview(datePicker)
        stackView.addArrangedSubview(descriptionTextView)

        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            titleTextView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
