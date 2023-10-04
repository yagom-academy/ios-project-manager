//
//  ToDoDetailViewController.swift
//  ProjectManager
//
//  Created by Moon on 2023/09/30.
//

import UIKit
import Combine

final class ToDoDetailViewController: UIViewController {
    // MARK: - Title Bar property
    private let leftButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.titleLabel?.font = .preferredFont(forTextStyle: .title3)
        
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Category.todo.rawValue
        label.font = .preferredFont(for: .title3, weight: .bold)
        label.adjustsFontForContentSizeCategory = true
        
        return label
    }()
    
    private lazy var rightButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.titleLabel?.font = .preferredFont(forTextStyle: .title3)
        button.addAction(dismissAction(), for: .touchUpInside)
        
        return button
    }()
    
    private let titleBarStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.backgroundColor = .systemGray6
        stackView.layoutMargins = .init(top: 10, left: 20, bottom: 10, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        return stackView
    }()
    
    // MARK: - Content property
    private let titleTextField: InsetTextField = {
        let textField = InsetTextField()
        textField.placeholder = "Title"
        textField.font = .preferredFont(forTextStyle: .title3)
        textField.backgroundColor = .systemBackground
        textField.adjustsFontForContentSizeCategory = true
        
        return textField
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        
        return datePicker
    }()
    
    private let bodyTextView: UITextView = {
        let textView = UITextView()
        textView.font = .preferredFont(forTextStyle: .title3)
        textView.adjustsFontForContentSizeCategory = true
        
        return textView
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.layoutMargins = .init(top: 10, left: 20, bottom: 30, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        return stackView
    }()
    
    private let titleShadowView: UIView = {
        let view = UIView()
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: .zero, height: 3)
        view.layer.shadowRadius = 3
        
        return view
    }()
    
    private let bodyShadowView: UIView = {
        let view = UIView()
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: .zero, height: 3)
        view.layer.shadowRadius = 3
        
        return view
    }()
    
    private let viewModel: ToDoDetailViewModel
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: ToDoDetailViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        configureUI()
        setUpDelegates()
        setUpLeftButton(isNew: viewModel.isEnableEdit)
        setUpBindings()
        setUpDatePickerBinding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        postToDoDetailViewWillDisappear()
    }
    
    private func setUpDelegates() {
        bodyTextView.delegate = self
    }
    
    // 추가 버튼으로 새로 만들어졌을 때는 Cancel, 기존에 있던 todo일 때는 Edit 기능 수행
    private func setUpLeftButton(isNew: Bool) {
        if isNew {
            leftButton.setTitle("Cancel", for: .normal)
            leftButton.addAction(dismissAction(), for: .touchUpInside) // TODO: 저장 없이 닫을 수 있도록 기능 추가
        } else {
            leftButton.setTitle("Edit", for: .normal)
            leftButton.addAction(enableEditContentAction(), for: .touchUpInside)// 유저와 상호작용이 가능하도록 하고 배경색 변경
        }
    }
    
    // datePicker의 값이 변경될 때마다 뷰 모델에 데이터를 보낼 수 있도록 타겟 추가
    private func setUpDatePickerBinding() {
        datePicker.addTarget(
            self,
            action: #selector(bindDatePicker),
            for: .valueChanged
        )
    }

    private func dismissAction() -> UIAction {
        return UIAction { [weak self] _ in
            self?.dismiss(animated: true)
        }
    }
    
    // 유저와 상호작용이 가능하도록 하고 배경색 변경할 수 있도록 뷰 모델에 알림
    private func enableEditContentAction() -> UIAction {
        return UIAction { [weak self] _ in
            self?.postEditButtonAction()
        }
    }
    
    private func postEditButtonAction() {
        NotificationCenter.default
            .post(
                name: NSNotification.Name("editButtonAction"),
                object: nil
            )
    }

    private func postToDoDetailViewWillDisappear() {
        NotificationCenter.default
            .post(
                name: NSNotification.Name("ToDoDetailViewWillDisappear"),
                object: nil
            )
    }
}

// MARK: - Configure UI
extension ToDoDetailViewController {
    private func configureUI() {
        setUpView()
        addSubviews()
        setUpConstraints()
    }
    
    private func setUpView() {
        view.backgroundColor = .systemBackground
    }
    
    private func addSubviews() {
        [leftButton, titleLabel, rightButton].forEach {
            titleBarStackView.addArrangedSubview($0)
        }
        
        titleShadowView.addSubview(titleTextField)
        bodyShadowView.addSubview(bodyTextView)
        
        [titleShadowView, datePicker, bodyShadowView].forEach {
            contentStackView.addArrangedSubview($0)
        }
        
        view.addSubview(titleBarStackView)
        view.addSubview(contentStackView)
    }
    
    private func setUpConstraints() {
        setUpTitleBarStackViewConstraints()
        setUpTitleTextFieldConstraints()
        setUpBodyTextViewConstraints()
        setUpContentStackViewConstraints()
    }
    
    private func setUpTitleBarStackViewConstraints() {
        titleBarStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleBarStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            titleBarStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            titleBarStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    private func setUpTitleTextFieldConstraints() {
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleTextField.leadingAnchor.constraint(equalTo: titleShadowView.leadingAnchor),
            titleTextField.trailingAnchor.constraint(equalTo: titleShadowView.trailingAnchor),
            titleTextField.topAnchor.constraint(equalTo: titleShadowView.topAnchor),
            titleTextField.bottomAnchor.constraint(equalTo: titleShadowView.bottomAnchor)
        ])
    }
    
    private func setUpBodyTextViewConstraints() {
        bodyTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bodyTextView.leadingAnchor.constraint(equalTo: bodyShadowView.leadingAnchor),
            bodyTextView.trailingAnchor.constraint(equalTo: bodyShadowView.trailingAnchor),
            bodyTextView.topAnchor.constraint(equalTo: bodyShadowView.topAnchor),
            bodyTextView.bottomAnchor.constraint(equalTo: bodyShadowView.bottomAnchor)
        ])
    }
    
    private func setUpContentStackViewConstraints() {
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            contentStackView.topAnchor.constraint(equalTo: titleBarStackView.bottomAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - UITextViewDelegate
extension ToDoDetailViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let originalText = textView.text else {
            return true
        }
        
        let newLength = originalText.count + text.count - range.length
        
        return newLength <= 1000
    }
}

// MARK: - Combine
extension ToDoDetailViewController {
    private func setUpBindings() {
        bindViewModelToView()
        bindViewToViewModel()
    }
    
    // 뷰에서 입력 받은 데이터를 뷰 모델로 보냄
    private func bindViewToViewModel() {
        titleTextField.publisher(for: \.text)
            .assign(to: \.title, on: viewModel)
            .store(in: &cancellables)
        bindDatePicker()
        bodyTextView.textPublisher
            .assign(to: \.body, on: viewModel)
            .store(in: &cancellables)
    }
    
    // 최초 실행 시 한 번만 값을 보내기 때문에 값이 변경 될 때마다 값을 보낼 수 있도록
    // datePicker.addTarget의 selector로 사용
    @objc
    private func bindDatePicker() {
        datePicker.publisher(for: \.date)
            .assign(to: \.deadline, on: viewModel)
            .store(in: &cancellables)
    }
    
    // 뷰 모델의 데이터를 받아 뷰에 적용
    private func bindViewModelToView() {
        viewModel.todoSubject
            .sink(receiveValue: { [weak self] in
                self?.titleLabel.text = $0.category
                self?.titleTextField.text = $0.title
                self?.datePicker.date = $0.deadline ?? Date()
                self?.bodyTextView.text = $0.body
            })
            .store(in: &cancellables)

        [titleTextField, datePicker, bodyTextView].forEach {
            viewModel.$isEnableEdit
                .assign(to: \.isUserInteractionEnabled, on: $0)
                .store(in: &cancellables)
            viewModel.$background
                .assign(to: \.backgroundColor, on: $0)
                .store(in: &cancellables)
        }
    }
}
