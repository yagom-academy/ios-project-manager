//
//  WorkManageView.swift
//  ProjectManager
//
//  Created by Judy on 2022/09/09.
//

import UIKit
import RxSwift

class WorkManageView: UIView {
    // MARK: - Properties
    let disposeBag = DisposeBag()
    let work = PublishSubject<Work>()
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Title"
        textField.borderStyle = .roundedRect
        textField.font = .preferredFont(forTextStyle: .body)
        textField.adjustsFontForContentSizeCategory = true
        return textField
    }()
    
    private let deadlinePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.backgroundColor = .systemBackground
        return datePicker
    }()
    
    private let contentTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .preferredFont(forTextStyle: .body)
        textView.adjustsFontForContentSizeCategory = true
        return textView
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Methods
    private func addSubView() {
        verticalStackView.addArrangedSubview(titleTextField)
        verticalStackView.addArrangedSubview(deadlinePicker)
        verticalStackView.addArrangedSubview(contentTextView)
        
        self.addSubview(verticalStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            verticalStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            verticalStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            verticalStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            verticalStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            
            contentTextView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5)
        ])
    }
    
    private func setupView() {
        addSubView()
        setupConstraints()
        bind()
        self.backgroundColor = .systemGray6
    }
    
    private func bind() {
        work.observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] work in
                guard let self = self else { return }
                self.titleTextField.text = work.title
                self.contentTextView.text = work.content
                self.deadlinePicker.date = work.deadline
            })
            .disposed(by: disposeBag)
    }
}
