//  ProjectManager - EditToDoViewController.swift
//  created by zhilly on 2023/01/18

import UIKit

class EditToDoViewController: UIViewController {
    
    private enum Constant {
        static let title = "TODO"
        static let doneButtonTitle = "Done"
        static let cancelButtonTitle = "Cancel"
        static let titlePlaceHolder = "Title"
        static let emptyTitle = "제목 없음"
        static let emptyBody = "내용 없음"
    }
    
    let viewModel: ToDoListViewModel
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = Constant.titlePlaceHolder
        textField.font = UIFont.preferredFont(forTextStyle: .callout)
        textField.borderStyle = .none
        textField.backgroundColor = .systemBackground
        textField.layer.shadowColor = UIColor.systemGray2.cgColor
        textField.layer.shadowOffset = CGSize(width: 0, height: 5)
        textField.layer.shadowOpacity = 1
        textField.layer.shadowRadius = 5.0
        textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.locale = Locale.current
        datePicker.minimumDate = Date()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        return datePicker
    }()
    
    private let bodyTextView: UITextView = {
        let textView = UITextView()
        
        textView.text = Constant.emptyBody
        textView.font = UIFont.preferredFont(forTextStyle: .callout)
        textView.textColor = .black
        textView.backgroundColor = .systemBackground
        textView.layer.masksToBounds = false
        textView.layer.shadowColor = UIColor.systemGray2.cgColor
        textView.layer.shadowOffset = CGSize(width: 0, height: 5)
        textView.layer.shadowOpacity = 1
        textView.layer.shadowRadius = 5.0
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    init(viewModel: ToDoListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupView()
    }
    
    private func configure() {
        title = Constant.title
        view.backgroundColor = .systemBackground
        
        setupBarButtonItem()
    }
    
    private func setupBarButtonItem() {
        let rightBarButton = UIBarButtonItem(title: Constant.doneButtonTitle,
                                             style: .done,
                                             target: self,
                                             action: #selector(tappedDoneButton))
        let leftBarButton = UIBarButtonItem(title: Constant.cancelButtonTitle,
                                            style: .done,
                                            target: self,
                                            action: #selector(tappedCancelButton))
        
        navigationItem.setRightBarButton(rightBarButton, animated: true)
        navigationItem.setLeftBarButton(leftBarButton, animated: true)
    }
    
    private func setupView() {
        view.addSubview(titleTextField)
        view.addSubview(datePicker)
        view.addSubview(bodyTextView)
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            titleTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 12),
            titleTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -12),
            titleTextField.topAnchor.constraint(equalTo: safeArea.topAnchor),
            titleTextField.heightAnchor.constraint(equalToConstant: 40),
            datePicker.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            datePicker.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 12),
            bodyTextView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 12),
            bodyTextView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -12),
            bodyTextView.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 12),
            bodyTextView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 12)
        ])
    }
    
    @objc
    private func tappedCancelButton() {
        dismiss(animated: true)
    }
    
    @objc
    private func tappedDoneButton() {
        let data = ToDo(title: titleTextField.text ?? Constant.emptyTitle,
                        body: bodyTextView.text ?? Constant.emptyBody,
                        deadline: datePicker.date,
                        state: .toDo)
        viewModel.addToDo(item: data)
        dismiss(animated: true)
    }
}
