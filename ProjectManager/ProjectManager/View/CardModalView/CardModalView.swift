//
//  CardModalView.swift
//  ProjectManager
//
//  Created by Derrick kim on 9/9/22.
//

import UIKit
import Then

final class CardModalView: UIView {
    private enum Const {
        static let placeHolder = "Title"
        static let datePickerlocale = "ko-KR"
        static let layerBorderWidth = 1.0
        static let stackViewSpacing = 16.0
        static let baseConstraint = 16.0
        static let zero = 0.0
        static let three = 3.0
    }
    
    var leftBarButtonItem = UIBarButtonItem()
    var rightBarButtonItem = UIBarButtonItem()
    
    lazy var navigationBar = UINavigationBar().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let titleTextField = UITextField().then {
        $0.font = .preferredFont(forTextStyle: .title3)
        $0.placeholder = Const.placeHolder
        $0.layer.borderColor = UIColor.systemGray4.cgColor
        $0.layer.borderWidth = Const.layerBorderWidth
    }
    
    let datePicker = UIDatePicker().then {
        $0.preferredDatePickerStyle = .wheels
        $0.datePickerMode = .date
        $0.locale = Locale(identifier: Const.datePickerlocale)
        $0.layer.borderWidth = Const.layerBorderWidth
        $0.layer.borderColor = UIColor.systemGray4.cgColor
    }
    
    let descriptionTextView = UITextView().then {
        $0.font = .preferredFont(forTextStyle: .body)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.borderWidth = Const.layerBorderWidth
        $0.layer.borderColor = UIColor.systemGray4.cgColor
        $0.isScrollEnabled = false
    }
    
    private lazy var rootStackView = UIStackView(
        arrangedSubviews: [titleTextField, datePicker, descriptionTextView]).then {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.axis = .vertical
            $0.spacing = Const.stackViewSpacing
        }
    
    private let rootScrollView = UIScrollView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    init() {
        super.init(frame: .zero)
        addSubViews()
        setupLayouts()
        registerNotificationForKeyboard()
        congifureToolBar()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func addSubViews() {
        self.addSubview(navigationBar)
        self.addSubview(rootScrollView)
        rootScrollView.addSubview(rootStackView)
    }
    
    private func setupLayouts() {
        configureNavigationBarLayout()
        configureRootScrollViewLayout()
        configureRootStackViewLayout()
    }
    
    private func configureNavigationBarLayout() {
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func configureRootScrollViewLayout() {
        NSLayoutConstraint.activate([
            rootScrollView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor,
                                                constant: Const.baseConstraint),
            rootScrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,
                                                   constant: -Const.baseConstraint),
            rootScrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                    constant: Const.baseConstraint),
            rootScrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                     constant: -Const.baseConstraint)
        ])
    }
    
    private func configureRootStackViewLayout() {
        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(equalTo: rootScrollView.topAnchor),
            rootStackView.leadingAnchor.constraint(equalTo: rootScrollView.leadingAnchor),
            rootStackView.trailingAnchor.constraint(equalTo: rootScrollView.trailingAnchor),
            rootStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,
                                                  constant: -Const.baseConstraint),
            rootStackView.widthAnchor.constraint(equalTo: rootScrollView.widthAnchor),
            
            titleTextField.heightAnchor.constraint(equalToConstant: Const.baseConstraint * Const.three)
        ])
    }
}

// MARK: Keyboard Actions

extension CardModalView {
    private func registerNotificationForKeyboard() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    private func congifureToolBar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
                                            target: nil,
                                            action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done,
                                         target: self,
                                         action: #selector(didTapDoneButton))
        
        toolBar.setItems([flexibleSpace, doneButton],
                         animated: false)
        
        titleTextField.inputAccessoryView = toolBar
        descriptionTextView.inputAccessoryView = toolBar
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        let contentInset = UIEdgeInsets(
            top: Const.zero,
            left: Const.zero,
            bottom: keyboardFrame.size.height,
            right: Const.zero)
        
        rootScrollView.contentInset = contentInset
        rootScrollView.scrollIndicatorInsets = contentInset
    }
    
    @objc private func keyboardWillHide() {
        let contentInset = UIEdgeInsets.zero
        rootScrollView.contentInset = contentInset
        rootScrollView.scrollIndicatorInsets = contentInset
    }
    
    @objc private func didTapDoneButton() {
        titleTextField.resignFirstResponder()
        descriptionTextView.resignFirstResponder()
    }
}
