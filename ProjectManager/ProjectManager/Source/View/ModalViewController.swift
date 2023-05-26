//
//  ModalViewController.swift
//  ProjectManager
//
//  Created by songjun, vetto on 2023/05/22.
//

import UIKit

final class ModalViewController: UIViewController {
    private let mainViewModel: MainViewModel
    private let modalType: ModalType
    private let scheduleType: ScheduleType?
    private let index: Int?

    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "제목을 입력해주세요"
        textField.borderStyle = .none
        textField.backgroundColor = .systemBackground
        textField.font = .preferredFont(forTextStyle: .title1)
        textField.layer.shadowColor = UIColor.systemGray2.cgColor
        textField.layer.shadowOffset = CGSize(width: 0, height: 5)
        textField.layer.shadowOpacity = 1
        textField.layer.shadowRadius = 5.0
        textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private let datePickerView: UIDatePicker = {
        let pickerView = UIDatePicker()
        pickerView.preferredDatePickerStyle = .wheels
        pickerView.locale = Locale(identifier: "ko_KR")
        pickerView.datePickerMode = .date
        pickerView.minimumDate = Date()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        return pickerView
    }()
    
    private let contentTextView: UITextView = {
        let contentTextView = UITextView()
        
        contentTextView.textColor = .black
        contentTextView.backgroundColor = .systemBackground
        contentTextView.font = .preferredFont(forTextStyle: .body)
        contentTextView.layer.masksToBounds = false
        contentTextView.layer.shadowColor = UIColor.systemGray2.cgColor
        contentTextView.layer.shadowOffset = CGSize(width: 0, height: 5)
        contentTextView.layer.shadowOpacity = 1
        contentTextView.layer.shadowRadius = 5.0
        contentTextView.translatesAutoresizingMaskIntoConstraints = false
        
        return contentTextView
    }()
    
    init(viewModel: MainViewModel,
         modalType: ModalType,
         scheduleType: ScheduleType? = nil,
         index: Int? = nil) {
        self.mainViewModel = viewModel
        self.modalType = modalType
        self.scheduleType = scheduleType
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavigationBar()
        configureUserInteraction()
        configureSchedule()
    }
    
    private func configureUI() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.backgroundColor = .systemBackground
        view.addSubview(titleTextField)
        view.addSubview(datePickerView)
        view.addSubview(contentTextView)
        
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 5),
            titleTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            titleTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
            
            datePickerView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            datePickerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            datePickerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            
            contentTextView.topAnchor.constraint(equalTo: datePickerView.bottomAnchor, constant: 20),
            contentTextView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            contentTextView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            contentTextView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20),
        ])
    }
    
    private func configureNavigationBar() {
        self.title = "TODO"
        
        let rightButton = UIBarButtonItem(title: "Done",
                                          style: .done,
                                          target: self,
                                          action: #selector(tapDoneButton))
        switch modalType {
        case .add:
            let leftButton = UIBarButtonItem(title: "Cancel",
                                             style: .done,
                                             target: self,
                                             action: #selector(tapCancelButton))
            self.navigationItem.rightBarButtonItem = rightButton
            self.navigationItem.leftBarButtonItem = leftButton
        case .edit:
            let leftButton = UIBarButtonItem(title: "Edit",
                                             style: .done,
                                             target: self,
                                             action: #selector(tapEditButton))
            self.navigationItem.rightBarButtonItem = rightButton
            self.navigationItem.leftBarButtonItem = leftButton
        }
    }
    
    @objc
    private func tapEditButton() {
        view.isUserInteractionEnabled = true
        titleTextField.textColor = .black
        contentTextView.textColor = .black
    }
    
    @objc
    private func tapDoneButton() {
        let schedule = mainViewModel.createSchedule(titleText: titleTextField.text,
                                                    contentText: contentTextView.text,
                                                    expirationDate: datePickerView.date)

        switch modalType {
        case .add:
            mainViewModel.addTodoSchedule(schedule)
            
            dismiss(animated: true)
        case .edit:
            guard let scheduleType, let index else { return }
            mainViewModel.updateSchedule(scheduleType: scheduleType,
                                         schedule: schedule,
                                         index: index)
            
            dismiss(animated: true)
        }
    }
    
    @objc
    private func tapCancelButton() {
        dismiss(animated: true)
    }
    
    private func configureUserInteraction() {
        switch modalType {
        case .add:
            view.isUserInteractionEnabled = true
        case .edit:
            view.isUserInteractionEnabled = false
            titleTextField.textColor = .lightGray
            contentTextView.textColor = .lightGray
        }
    }
    
    private func configureSchedule() {
        if modalType == .edit {
            guard let scheduleType, let index else { return }
            let schedules = mainViewModel.fetchSchedule(scheduleType: scheduleType)
            titleTextField.text = schedules[index].title
            datePickerView.date = schedules[index].expirationDate
            contentTextView.text = schedules[index].content
        }
    }
}
