//
//  DetailViewController.swift
//  ProjectManager
//
//  Created by 리나 on 2021/03/11.
//

import UIKit

final class DetailViewController: UIViewController {
    
    // MARK: - Property
    
    var isNew: Bool = false
    var index: Int? = nil
    var thing: Thing? = nil
    var tableView: ThingTableView?
    
    // MARK: - Outlet
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        makeShadow(view: textField)
        textField.backgroundColor = .white
        textField.placeholder = Strings.titlePlaceHolder
        textField.isUserInteractionEnabled = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.isUserInteractionEnabled = false
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        makeShadow(view: textView)
        textView.text = Strings.descriptionPlaceHolder
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        return textView
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionTextView.delegate = self
        configureConstraints()
        configureNavigationBar()
        setContents()
    }
    
    // MARK: - UI
    
    private func configureConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        view.backgroundColor = .white
        view.addSubview(titleTextField)
        view.addSubview(datePicker)
        view.addSubview(descriptionTextView)
        
        NSLayoutConstraint.activate([
            titleTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            titleTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
            titleTextField.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            titleTextField.heightAnchor.constraint(equalToConstant: 50),
            
            datePicker.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            datePicker.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
            datePicker.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 10),
            
            descriptionTextView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            descriptionTextView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
            descriptionTextView.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 10),
            descriptionTextView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10),
        ])
    }
    
    static private func makeShadow(view: UIView) {
        view.layer.shadowOffset = CGSize(width: 1, height: 2)
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 0.5
        view.layer.masksToBounds = false
    }
    
    private func setContents() {
        guard let thing = thing else {
            return
        }
        titleTextField.text = thing.title
        descriptionTextView.text = thing.detailDescription
        datePicker.date = thing.date
    }
    
    // MARK: - Navigation bar
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(touchUpDoneButton))
        if isNew {
            toggleEditMode()
        } else {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(touchUpEditButton))
        }
    }
    
    // MARK: - Data CURD
    
    @objc private func touchUpDoneButton() {
        guard let title = titleTextField.text,
              let description = descriptionTextView.text else {
            return
        }
        let date = datePicker.date.timeIntervalSince1970
        
        if isNew {
            guard let todoTableView = tableView as? TodoTableView else {
                return
            }
            todoTableView.createThing(title, description, date)
            HistoryManager.insertAddHistory(title: title)
        } else if let thing = thing {
            tableView?.updateThing(thing, title, description, date)
        }
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func touchUpCancelButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func touchUpEditButton() {
        toggleEditMode()
    }
    
    private func toggleEditMode() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(touchUpCancelButton))
        titleTextField.isUserInteractionEnabled = true
        datePicker.isUserInteractionEnabled = true
        descriptionTextView.isEditable = true
    }
}

// MARK: - TexViewDlegate

extension DetailViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return self.textLimit(existingText: textView.text, newText: text, limit: 1000)
    }
    
    private func textLimit(existingText: String?, newText: String, limit: Int) -> Bool {
        let text = existingText ?? String.empty
        let isAtLimit = text.count + newText.count <= limit
        return isAtLimit
    }
}
