//
//  PlusTodoViewController.swift
//  ProjectManager
//
//  Created by 리지 on 2023/05/17.
//

import UIKit
import Combine

final class PlusTodoViewController: UIViewController {
    enum Mode {
        case create, edit
    }
    
    weak var delegate: SavingItemDelegate?
    private let viewModel: PlusTodoViewModel?
    private var mode: Mode
    
    init(plusTodoViewModel: PlusTodoViewModel?, mode: Mode) {
        self.viewModel = plusTodoViewModel
        self.mode = mode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let todoView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
        
        return view
    }()
    
    private let navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.isTranslucent = false
        navigationBar.backgroundColor = .systemBackground
        
        return navigationBar
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private let titleField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        textField.textColor = UIColor.black
        textField.backgroundColor = UIColor.white
        textField.attributedPlaceholder = NSAttributedString(string: "Title",
                                                             attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .title3)])
        
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.shadowOffset = CGSize(width: 0, height: 3)
        textField.layer.shadowOpacity = 0.5
        textField.layer.shadowRadius = 3.0
        
        return textField
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: Locale.current.identifier)
        
        return datePicker
    }()
    
    private let textView: UITextView = {
        let textView = UITextView()
        let textViewPlaceholderText = "여기는 할 일 내용을 입력하는 곳입니다. \n입력 가능한 글자수는 1000자로 제한합니다."
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.textColor = UIColor.black
        textView.backgroundColor = UIColor.white
        textView.text = textViewPlaceholderText
        
        textView.layer.masksToBounds = false
        textView.layer.shadowColor = UIColor.black.cgColor
        textView.layer.shadowOffset = CGSize(width: 0, height: 3)
        textView.layer.shadowOpacity = 0.5
        textView.layer.shadowRadius = 3.0
        
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTodoView()
        configureNavigationBar()
        configureStackView()
        editTodoItem()
        textView.delegate = self
    }
    
    private func setUpTodoView() {
        view.addSubview(todoView)
        todoView.addSubview(navigationBar)
        todoView.addSubview(stackView)
      
        let top: CGFloat = 40
        let leading: CGFloat = 30
        let bottom: CGFloat = -20
        let trailing: CGFloat = -30
        
        todoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            todoView.topAnchor.constraint(equalTo: view.topAnchor, constant: top),
            todoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leading),
            todoView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom),
            todoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailing)
        ])
    }
  
    private func configureNavigationBar() {
        let title = "TODO"
        let done = "Done"
        var leftButtonTitle = ""

        switch mode {
        case .create:
            leftButtonTitle = "Cancel"
        default:
            leftButtonTitle = "Edit"
        }
        
        let doneButton = UIBarButtonItem(title: done, style: .done, target: self, action: #selector(doneButtonTapped))
        let leftButton = UIBarButtonItem(title: leftButtonTitle, style: .plain, target: self, action: #selector(leftButtonTapped))
        
        let navigationItem = UINavigationItem(title: title)
        navigationItem.rightBarButtonItem = doneButton
        navigationItem.leftBarButtonItem = leftButton
        navigationBar.items = [navigationItem]
        
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: todoView.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: todoView.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: todoView.trailingAnchor)
        ])
    }
    
    @objc private func doneButtonTapped() {
        switch mode {
        case .create:
            guard let plan = configurePlan() else { return }
            self.delegate?.create(plan)
            self.dismiss(animated: false)
        default:
            guard let plan = updatePlan() else { return }
            self.delegate?.update(by: plan)
            self.dismiss(animated: false)
        }
    }
    
    @objc private func leftButtonTapped() {
        switch mode {
        case .create:
            self.dismiss(animated: false)
        default:
            showEditAlert()
        }
    }
    
    private func showEditAlert() {
        let editTitle = "수정모드"
        let message = "수정사항을 입력 후 Done 버튼을 눌러주세요"
        let okTitle = "확인"
        let alert = UIAlertController(title: editTitle, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: okTitle, style: .default) { [weak self] _ in
            self?.viewModel?.changEditMode()
        }
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    private func configurePlan() -> Plan? {
        guard let title = self.titleField.text,
              let body = self.textView.text else { return nil }
        
        let date = self.datePicker.date
        
        return viewModel?.configureInitialPlan(title: title, body: body, date: date)
    }
    
    private func updatePlan() -> Plan? {
        guard let title = self.titleField.text,
              let body = self.textView.text else { return nil }
        
        let date = self.datePicker.date
        return viewModel?.updateCurrentPlan(title: title, body: body, date: date)
    }
    
    private func configureStackView() {
        stackView.addArrangedSubview(titleField)
        stackView.addArrangedSubview(datePicker)
        stackView.addArrangedSubview(textView)
        
        let top: CGFloat = 10
        let leading: CGFloat = 15
        let bottom: CGFloat = -15
        let trailing: CGFloat = -20
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: top),
            stackView.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor, constant: leading),
            stackView.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor, constant: -bottom),
            stackView.bottomAnchor.constraint(equalTo: todoView.bottomAnchor, constant: -trailing)
        ])
    }
    
    private func editTodoItem() {
        guard let plan = viewModel?.fetchCurrentPlan() else { return }
        
        self.titleField.text = plan.title
        self.textView.text = plan.body
        self.datePicker.date = plan.date
    }
}

extension PlusTodoViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = nil
    }
}
