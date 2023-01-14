//
//  DetailViewController.swift
//  ProjectManager
//
//  Created by Mangdi on 2023/01/14.
//

import UIKit

class DetailViewController: UIViewController {

    private lazy var navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        let navigationItem = UINavigationItem(title: "TODO")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: nil)
        navigationBar.items = [navigationItem]
        navigationBar.barTintColor = UIColor.systemGray6
        return navigationBar
    }()

    private let titleTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.preferredFont(forTextStyle: .title3)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.7).cgColor
        textView.clipsToBounds = false
        textView.layer.shadowOpacity = 0.3
        textView.layer.shadowOffset = CGSize(width: 0, height: 3)
        textView.textColor = UIColor.systemGray3
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return textView
    }()

    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.preferredFont(forTextStyle: .title3)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.7).cgColor
//        textField.clipsToBounds = false
        textField.layer.shadowOpacity = 0.3
        textField.layer.shadowOffset = CGSize(width: 0, height: 3)
        textField.placeholder = "Title"
        textField.backgroundColor = .white
        textField.textColor = UIColor.systemGray3
        // textview처럼 textContainerInset기능이 없음 따라서 아래와 같이 작성
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(navigationBar)
        view.addSubview(titleTextView)
        view.addSubview(titleTextField)
    }

    override func viewDidLayoutSubviews() {
        configureSubViews()
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureSubViews() {
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            titleTextView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 8),
            titleTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            titleTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
//            titleTextView.bottomAnchor.constraint(equalTo: titleTextField.topAnchor),
            titleTextView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1),

            titleTextField.topAnchor.constraint(equalTo: titleTextView.bottomAnchor, constant: 40),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            titleTextField.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1)
        ])
    }

}
