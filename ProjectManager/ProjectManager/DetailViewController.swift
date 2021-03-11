//
//  DetailViewController.swift
//  ProjectManager
//
//  Created by 임성민 on 2021/03/10.
//

import UIKit

class DetailViewController: UIViewController {
    let titleTextView: UITextView = {
        let titleTextView = UITextView()
        titleTextView.isEditable = false
        titleTextView.textContainerInset = UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
        titleTextView.isScrollEnabled = false
        titleTextView.backgroundColor = .white
        titleTextView.layer.shadowOpacity = 1
        titleTextView.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
        titleTextView.layer.shadowOffset = CGSize(width: 0, height: 2)
        titleTextView.layer.shadowColor = UIColor.gray.cgColor
        titleTextView.layer.masksToBounds = false
        return titleTextView
    }()
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.isEnabled = false
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        return datePicker
    }()
    let bodyTextView: UITextView = {
        let bodyTextView = UITextView()
        bodyTextView.isEditable = false
        bodyTextView.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        bodyTextView.backgroundColor = .white
        bodyTextView.layer.shadowOpacity = 1
        bodyTextView.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
        bodyTextView.layer.shadowOffset = CGSize(width: 0, height: 2)
        bodyTextView.layer.shadowColor = UIColor.gray.cgColor
        bodyTextView.layer.masksToBounds = false
        return bodyTextView
    }()
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
    }()
    lazy var leftBarButton: UIBarButtonItem = {
        let leftBarButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(touchUpLeftBarButton))
        return leftBarButton
    }()
    lazy var doneBarButton: UIBarButtonItem = {
        let doneBarButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(touchUpDoneBarButton))
        return doneBarButton
    }()
    var isNew: Bool = false {
        didSet {
            if isNew {
                setEditMode()
            }
        }
    }
    private var isEditMode: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = doneBarButton
        view.backgroundColor = .white
        stackView.addArrangedSubview(titleTextView)
        stackView.addArrangedSubview(datePicker)
        stackView.addArrangedSubview(bodyTextView)
        view.addSubview(stackView)
        configureConstraints()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        reset()
    }
    
    private func configureConstraints() {
        titleTextView.translatesAutoresizingMaskIntoConstraints = false
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        bodyTextView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            titleTextView.heightAnchor.constraint(equalToConstant: 45),
            titleTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            titleTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            datePicker.heightAnchor.constraint(equalToConstant: 150),
            bodyTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            bodyTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
        ])
    }
    
    func setContents(_ thing: Thing, _ title: String) {
        navigationItem.title = title
        titleTextView.text = thing.title
        let date = Date(timeIntervalSince1970: TimeInterval(thing.date))
        datePicker.setDate(date, animated: false)
        bodyTextView.text = thing.body
    }
    
    func reset() {
        navigationItem.title = nil
        leftBarButton.title = "Edit"
        titleTextView.text = nil
        datePicker.setDate(Date(), animated: false)
        bodyTextView.text = nil
        titleTextView.isEditable = false
        datePicker.isEnabled = false
        bodyTextView.isEditable = false
        isNew = false
        isEditMode = false
    }
    
    private func setEditMode() {
        leftBarButton.title = "Cancel"
        titleTextView.isEditable = true
        datePicker.isEnabled = true
        bodyTextView.isEditable = true
    }
    
    @IBAction func touchUpLeftBarButton() {
        if isNew {
            dismiss(animated: true, completion: nil)
        } else {
            isEditMode.toggle()
            if isEditMode {
                setEditMode()
            } else {
                dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func touchUpDoneBarButton() {
        if isNew {
            // TODO: Create
        } else if isEditMode {
            // TODO: Update
        }
        dismiss(animated: true, completion: nil)
    }
}
