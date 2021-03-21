//
//  ListItemDetailViewController.swift
//  ProjectManager
//
//  Created by sole on 2021/03/09.
//

import UIKit

class ListItemDetailViewController: UIViewController {
    private var statusType: ItemStatus
    private var detailViewType: DetailViewType
    private var itemIndex: Int
    private let descriptionTextViewTextMaxCount: Int = 1000
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Title"
        textField.borderStyle = .roundedRect
        textField.layer.shadowColor = UIColor.systemGray4.cgColor
        textField.layer.masksToBounds = false
        textField.layer.shadowOffset = CGSize(width: 5, height: 5)
        textField.layer.shadowRadius = 1
        textField.layer.shadowOpacity = 1
        return textField
    }()
    private let deadLineDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.timeZone = NSTimeZone.local
        return datePicker
    }()
    private let deadLineDatePickerEnableToggleButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("날짜 선택 안함", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(systemName: "square"), for: .normal)
        button.setImage(UIImage(systemName: "square.fill"), for: .selected)
        button.addTarget(self, action: #selector(touchUpCheckboxButton), for: .touchUpInside)
        return button
    }()
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .preferredFont(forTextStyle: .body)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.systemGray.cgColor
        textView.layer.cornerRadius = 5
        textView.layer.masksToBounds = false
        textView.layer.shadowOffset = CGSize(width: 5, height: 5)
        textView.layer.shadowRadius = 1
        textView.layer.shadowOpacity = 1
        textView.layer.shadowColor = UIColor.systemGray4.cgColor
        return textView
    }()
    private lazy var doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(done))
    
    init(statusType: ItemStatus, detailViewType: DetailViewType, itemIndex: Int = 0) {
        self.statusType = statusType
        self.detailViewType = detailViewType
        self.itemIndex = itemIndex
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDelegate()
        configureView()
        configureAutoLayout()
        configureNavigationBar()
        configureEditView()
    }
    
    private func setUpDelegate() {
        descriptionTextView.delegate = self
        titleTextField.delegate = self
    }
    
    private func configureView() {
        view.backgroundColor = .white
        view.addSubview(titleTextField)
        view.addSubview(deadLineDatePicker)
        view.addSubview(deadLineDatePickerEnableToggleButton)
        view.addSubview(descriptionTextView)
    }
    
    private func configureAutoLayout() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            titleTextField.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            titleTextField.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.95),
            titleTextField.heightAnchor.constraint(equalToConstant: 80),
            
            deadLineDatePicker.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 10),
            deadLineDatePicker.centerXAnchor.constraint(equalTo: titleTextField.centerXAnchor),
            deadLineDatePicker.widthAnchor.constraint(equalTo: titleTextField.widthAnchor),
            
            deadLineDatePickerEnableToggleButton.topAnchor.constraint(equalTo: deadLineDatePicker.bottomAnchor, constant: 10),
            deadLineDatePickerEnableToggleButton.trailingAnchor.constraint(equalTo: deadLineDatePicker.trailingAnchor),
            
            descriptionTextView.topAnchor.constraint(equalTo: deadLineDatePickerEnableToggleButton.bottomAnchor, constant: 10),
            descriptionTextView.centerXAnchor.constraint(equalTo: titleTextField.centerXAnchor),
            descriptionTextView.widthAnchor.constraint(equalTo: titleTextField.widthAnchor),
            descriptionTextView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -30)
        ])
    }
    
    private func configureEditView() {
        if detailViewType == .edit {
            let todo = ItemList.shared.getItem(statusType: statusType, index: itemIndex)
            fillContents(todo: todo)
            makeIneditable()
        }
    }
    
    private func makeIneditable() {
        titleTextField.isUserInteractionEnabled = false
        descriptionTextView.isEditable = false
        deadLineDatePicker.isEnabled = false
    }
    
    private func fillContents(todo: Todo) {
        titleTextField.text = todo.title
        descriptionTextView.text = todo.descriptions
        
        if let deadline = todo.deadLine {
            deadLineDatePicker.date = deadline
        } else {
            deadLineDatePickerEnableToggleButton.isSelected.toggle()
            deadLineDatePicker.isEnabled.toggle()
        }
    }
    
    @objc private func touchUpCheckboxButton(_ sender: UIButton) {
        sender.isSelected.toggle()
        deadLineDatePicker.isEnabled.toggle()
    }
    
    // MARK: - Navigation Bar
    private func configureNavigationBar() {
        let leftBarbutton: UIBarButtonItem = {
            let barButton = UIBarButtonItem()
            barButton.title = detailViewType.leftButtonName
            barButton.style = .plain
            barButton.target = self
            return barButton
        }()
        
        switch detailViewType {
        case .create:
            leftBarbutton.action = #selector(cancel)
            doneButton.isEnabled = false
        case .edit:
            leftBarbutton.action = #selector(edit)
        }
        
        navigationItem.title = statusType.title
        navigationItem.leftBarButtonItem = leftBarbutton
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc private func edit() {
        titleTextField.isUserInteractionEnabled = true
        descriptionTextView.isEditable = true
        deadLineDatePicker.isEnabled = !deadLineDatePickerEnableToggleButton.isSelected
    }
    
    @objc private func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func done() {
        guard let title = titleTextField.text else {
            dismiss(animated: true, completion: nil)
            return
        }
        let description = descriptionTextView.text
        let deadline = deadLineDatePickerEnableToggleButton.isSelected ? nil: deadLineDatePicker.date
        let todo = Todo(title: title, descriptions: description, deadLine: deadline)
        
        switch detailViewType {
        case .create:
            ItemList.shared.insertItem(statusType: .todo, item: todo)
        case .edit:
            ItemList.shared.updateItem(statusType: statusType, index: itemIndex, item: todo)
        }
        
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITextViewDelegate
extension ListItemDetailViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let textViewText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let textMaxCount = textViewText.count
        return textMaxCount <= descriptionTextViewTextMaxCount
    }
}

// MARK: - UITextFieldDelegate
extension ListItemDetailViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        doneButton.isEnabled = titleTextField.text != ""
    }
}
