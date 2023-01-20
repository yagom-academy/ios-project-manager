//
//  TaskDetailViewController.swift
//  ProjectManager
//
//  Created by ayaan, jpush on 2023/01/18.
//

import UIKit

import RxCocoa
import RxSwift

final class TaskDetailViewController: UIViewController {
    private let viewModel: TaskDetailViewModel
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOffset = CGSize(width: 0, height: 4)
        label.layer.shadowOpacity = 0.3
        label.layer.shadowRadius = 5
        label.layer.masksToBounds = false
        
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 24)
        label.backgroundColor = .systemBackground
        
        return label
    }()
    private let datePickerView: UIDatePicker = {
        let datePicker = UIDatePicker()
        
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        
        return datePicker
    }()
    private let contentLabel: UITextView = {
        let textView = UITextView()
        
        textView.layer.shadowColor = UIColor.black.cgColor
        textView.layer.shadowOffset = CGSize(width: 0, height: 2)
        textView.layer.shadowOpacity = 0.5
        textView.layer.shadowRadius = 5
        textView.layer.masksToBounds = false
        
        textView.font = .systemFont(ofSize: 18)
        textView.backgroundColor = .systemBackground
        
        return textView
    }()
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        
        return stackView
    }()
    private let editBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(systemItem: .edit)
        
        return barButton
    }()
    private let doneBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(systemItem: .done)
        
        return barButton
    }()
    
    init(viewModel: TaskDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBarButton()
        setUI()
        bind()
    }
}

private extension TaskDetailViewController {
    func setNavigationBarButton() {
        navigationItem.leftBarButtonItem = editBarButton
        navigationItem.rightBarButtonItem = doneBarButton
    }
    
    func setUI() {
        let spacing: CGFloat = 8
        let safeArea = view.safeAreaLayoutGuide
        
        [titleLabel, datePickerView, contentLabel].forEach { view in
            stackView.addArrangedSubview(view)
        }
        view.backgroundColor = .systemBackground
        view.addSubview(stackView)
        
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        contentLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: spacing),
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: spacing),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -spacing),
            stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -spacing),
        ])
    }
    
    func bind() {
        let input = TaskDetailViewModel.Input(editButtonTappedEvent: editBarButton.rx.tap.asObservable(),
                                              doneButtonTappedEvent: doneBarButton.rx.tap.asObservable())
        let output = viewModel.transform(with: input)
        
        setContents(with: output.task)
    }
    
    func setContents(with task: Task) {
        let date = Date(timeIntervalSince1970: task.deadLine)
        
        titleLabel.text = task.title
        contentLabel.text = task.content
        datePickerView.minimumDate = date
        datePickerView.maximumDate = date
    }
}
