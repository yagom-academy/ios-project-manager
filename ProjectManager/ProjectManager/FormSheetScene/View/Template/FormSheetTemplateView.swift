//
//  FormSheetTemplateView.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/09.
//

import UIKit

final class FormSheetTemplateView: UIView {
    
    // MARK: - UIComponents
    private let mainScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let verticalStackView = DefaultStackViewBuilder()
        .useAutoLayout()
        .useLayoutMargin()
        .setAxis(.vertical)
        .setLayoutMargin(top: 10,
                         left: 10,
                         bottom: 20,
                         right: 10)
        .stackView
    
    let titleTextField = DefaultTextFieldBuilder()
        .useAutoLayout()
        .setFont(UIFont.preferredFont(forTextStyle: .title3))
        .setPlaceholder("Title")
        .setBackgroundColor(.white)
        .setHeightAnchor(50)
        .addLeftPadding()
        .setLayerBorderWidth(1)
        .setLayerBorderColor(.systemGray6)
        .setLayerShadowOffset(width: 0, height: 2)
        .setLayerShadowOpacity(0.5)
        .textField
    
    let datePicker = DefaultDatePickerBuilder()
        .useAutoLayout()
        .setStyle(.wheels)
        .setMode(.date)
        .setLocale("ko-KR")
        .setTimeZone(.autoupdatingCurrent)
        .datePicker
    
    let bodyTextView = DefaultTextViewBuilder()
        .useAutoLayout()
        .isScrollEnable(false)
        .setFont(UIFont.preferredFont(forTextStyle: .body))
        .setBackgroundColor(.white)
        .setLayerMaskToBounds(false)
        .setLayerBorderWidth(1)
        .setLayerBorderColor(.systemGray6)
        .setLayerShadowOffset(width: 0, height: 2)
        .setLayerShadowOpacity(0.5)
        .textView
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupKeyboard()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func setupView() {
        backgroundColor = .systemBackground
        addSubview(mainScrollView)
        mainScrollView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(titleTextField)
        verticalStackView.addArrangedSubview(datePicker)
        verticalStackView.addArrangedSubview(bodyTextView)
        
        NSLayoutConstraint.activate([
            mainScrollView.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor
            ),
            mainScrollView.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor
            ),
            mainScrollView.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor
            ),
            mainScrollView.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor
            )
        ])
        
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(
                equalTo: mainScrollView.contentLayoutGuide.topAnchor
            ),
            verticalStackView.bottomAnchor.constraint(
                equalTo: mainScrollView.contentLayoutGuide.bottomAnchor
            ),
            verticalStackView.leadingAnchor.constraint(
                equalTo: mainScrollView.contentLayoutGuide.leadingAnchor
            ),
            verticalStackView.trailingAnchor.constraint(
                equalTo: mainScrollView.contentLayoutGuide.trailingAnchor
            ),
            verticalStackView.widthAnchor.constraint(
                equalTo: mainScrollView.widthAnchor
            )
        ])
    }
    
    func setupData(with model: Todo?) {
        guard let model = model else { return }
        titleTextField.text = model.title
        datePicker.date = model.date
        bodyTextView.text = model.body
    }
    
    func generateTodoModel(with category: String?) -> Todo? {
        guard let title = titleTextField.text,
              let body = bodyTextView.text else { return nil }
        let date = datePicker.date
        let todo = Todo()
        todo.category = category ?? Category.todo
        todo.title = title
        todo.body = body
        todo.date = date
        return todo
    }
    
    // MARK: - Keyboard Settings
    private func setupKeyboard() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillAppear(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillDisappear(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc private func keyboardWillAppear(_ sender: Notification) {
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        let contentInset = UIEdgeInsets(
            top: 0.0,
            left: 0.0,
            bottom: keyboardFrame.size.height-300,
            right: 0.0)
        mainScrollView.contentInset = contentInset
        mainScrollView.scrollIndicatorInsets = contentInset
    }
    
    @objc private func keyboardWillDisappear(_ sender: Notification) {
        let contentInset = UIEdgeInsets.zero
        mainScrollView.contentInset = contentInset
        mainScrollView.scrollIndicatorInsets = contentInset
    }
}
