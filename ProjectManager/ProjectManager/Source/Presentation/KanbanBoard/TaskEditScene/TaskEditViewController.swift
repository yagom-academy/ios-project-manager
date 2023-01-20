//
//  TaskEditViewController.swift
//  ProjectManager
//
//  Created by ayaan, jpush on 2023/01/18.
//

import UIKit

import RxCocoa
import RxSwift

final class TaskEditViewController: UIViewController {
    private let viewModel: TaskEditViewModel
    private let disposeBag = DisposeBag()
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.shadowOffset = CGSize(width: 0, height: 4)
        textField.layer.shadowOpacity = 0.3
        textField.layer.shadowRadius = 5
        textField.layer.masksToBounds = false
        
        textField.font = .boldSystemFont(ofSize: 24)
        textField.backgroundColor = .systemBackground
        
        return textField
    }()
    private let datePickerView: UIDatePicker = {
        let datePicker = UIDatePicker()
        
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        
        return datePicker
    }()
    private let contentTextView: UITextView = {
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
        
        return stackView
    }()
    private let cancelBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(systemItem: .cancel)
        
        return barButton
    }()
    private let doneBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(systemItem: .done)
        
        return barButton
    }()
    
    init(viewModel: TaskEditViewModel) {
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

private extension TaskEditViewController {
    func setNavigationBarButton() {
        navigationItem.leftBarButtonItem = cancelBarButton
        navigationItem.rightBarButtonItem = doneBarButton
    }
    
    func setUI() {
        let spacing: CGFloat = 8
        let safeArea = view.safeAreaLayoutGuide
        
        [titleTextField, datePickerView, contentTextView].forEach { view in
            stackView.addArrangedSubview(view)
        }
        view.backgroundColor = .systemBackground
        view.addSubview(stackView)
        
        titleTextField.setContentHuggingPriority(.defaultHigh, for: .vertical)
        contentTextView.setContentHuggingPriority(.defaultLow, for: .vertical)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: spacing),
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: spacing),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -spacing),
            stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -spacing),
        ])
    }
    
    func bind() {
        let input = TaskEditViewModel.Input(titleDidEditEvent: titleTextField.rx.text.orEmpty.skip(1).asObservable(),
                                            contentDidEditEvent: contentTextView.rx.text.orEmpty.skip(1).asObservable(),
                                            datePickerDidEditEvent: datePickerView.rx.date.asObservable(),
                                            doneButtonTapEvent: doneBarButton.rx.tap.asObservable())
        let output = viewModel.transform(from: input)
        
        output.isFill
            .subscribe(onNext: { [weak self] isFill in
                self?.doneBarButton.isEnabled = isFill
            })
            .disposed(by: disposeBag)
        
        output.isSuccess
            .subscribe(onNext: { [weak self] isSuccess in
                if isSuccess {
                    self?.dismiss(animated: true)
                } else {
                    self?.showAlert()
                }
            })
            .disposed(by: disposeBag)
        
        cancelBarButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
            
        setContents(with: output.task)
    }
    
    func setContents(with task: Task) {
        let date = Date(timeIntervalSince1970: task.deadLine)
        
        titleTextField.text = task.title
        contentTextView.text = task.content
        datePickerView.date = date
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "수정 실패",
                                                message: "수정에 실패했습니다.",
                                                preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default)
        
        alertController.addAction(action)
        
        present(alertController, animated: true)
    }
}
