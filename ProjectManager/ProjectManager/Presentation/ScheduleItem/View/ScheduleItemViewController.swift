//
//  ScheduleDetailView.swift
//  ProjectManager
//
//  Created by Jae-hoon Sim on 2022/03/09.
//

import UIKit
import RxSwift
import RxCocoa

private enum Design {
    static let stackViewSpacing = 5.0
    static let titleTextFieldPlaceHolder = "Title"
    static let titleTextFieldLeftPaddingWidth = 15.0
    static let rightBarButtonTitle = "완료"
    static let viewBackgroundColor = UIColor.white
    static let stackViewLeadingAnchorConstant = 10.0
    static let stackViewTrailingAnchorConstant = -10.0
    static let stackViewTopAnchorConstant = 4.0
    static let stackViewBottomAnchorConstant = -20.0
    static let titleTextFieldHeightAnchorMultiplier = 0.08
    static let bodyTextViewHeightAnchorMultiplier = 0.55
}

class ScheduleItemViewController: UIViewController {

    // MARK: - Properties

    var viewModel: ScheduleItemViewModel?

    private let bag = DisposeBag()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = Design.stackViewSpacing
        return stackView
    }()

    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Design.titleTextFieldPlaceHolder
        textField.shadow()
        let paddingSize: CGSize = CGSize(
            width: Design.titleTextFieldLeftPaddingWidth,
            height: textField.frame.height
        )
        let padding = UIView(frame: CGRect(origin: .zero, size: paddingSize))
        textField.leftView = padding
        textField.leftViewMode = .always

        return textField
    }()

    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        if #available(iOS 13.5, *) {
            datePicker.preferredDatePickerStyle = .wheels
            }
        return datePicker
    }()

    private let textStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.shadow()
        return stackView
    }()

    private let bodyTextView: UITextView = {
        let textView = UITextView()
        return textView
    }()

    private let leftBarButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem()
        return barButtonItem
    }()

    private let rightBarButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem()
        barButtonItem.title = Design.rightBarButtonTitle
        return barButtonItem
    }()

    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configure()
    }
}

// MARK: - Private Methods

private extension ScheduleItemViewController {
    func configure() {
        self.view.backgroundColor = Design.viewBackgroundColor
        self.configureHierarchy()
        self.configureConstraint()
        self.configureNavigationBar()
        self.binding()
    }

    func configureHierarchy() {
        self.view.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.titleTextField)
        self.stackView.addArrangedSubview(self.datePicker)
        self.textStackView.addArrangedSubview(self.bodyTextView)
        self.stackView.addArrangedSubview(self.textStackView)
    }

    func configureConstraint() {
        configureStackViewConstraint()
        configureSubViewsConstraint()
    }

    func configureStackViewConstraint() {
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.stackView.leadingAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,
                constant: Design.stackViewLeadingAnchorConstant
            ),
            self.stackView.trailingAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,
                constant: Design.stackViewTrailingAnchorConstant
            ),
            self.stackView.topAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                constant: Design.stackViewTopAnchorConstant
            ),
            self.stackView.bottomAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,
                constant: Design.stackViewBottomAnchorConstant
            )
        ])
    }

    func configureSubViewsConstraint() {
        self.titleTextField.translatesAutoresizingMaskIntoConstraints = false
        self.bodyTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleTextField.heightAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.heightAnchor,
                multiplier: Design.titleTextFieldHeightAnchorMultiplier
            ),
            self.bodyTextView.heightAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.heightAnchor,
                multiplier: Design.bodyTextViewHeightAnchorMultiplier
            )
        ])
    }

    func configureNavigationBar() {
        self.navigationItem.rightBarButtonItem = rightBarButton
        self.navigationItem.leftBarButtonItem = leftBarButton
    }

    func binding() {
        let input = setInput()
        guard let output = self.viewModel?.transform(input: input, disposeBag: self.bag) else {
            return
        }

        self.bindingOutput(output: output)
    }

    func setInput() -> ScheduleItemViewModel.Input {
        return ScheduleItemViewModel.Input(
            leftBarButtonDidTap: self.leftBarButton.rx.tap.asObservable(),
            rightBarButtonDidTap: self.rightBarButton.rx.tap.asObservable(),
            scheduleTitleTextDidChange: self.titleTextField.rx.text.orEmpty.asObservable(),
            scheduleDateDidChange: self.datePicker.rx.date.asObservable(),
            scheduleBodyTextDidChange: self.bodyTextView.rx.text.orEmpty.asObservable(),
            viewDidDisappear: self.rx.methodInvoked(#selector(UIViewController.viewDidDisappear))
                .map { _ in }
        )
    }

    func bindingOutput(output: ScheduleItemViewModel.Output) {
        output.scheduleProgress
            .drive(self.rx.title)
            .disposed(by: self.bag)

        output.scheduleTitleText
            .drive(self.titleTextField.rx.text)
            .disposed(by: self.bag)

        output.scheduleDate
            .drive(self.datePicker.rx.date)
            .disposed(by: self.bag)

        output.scheduleBodyText
            .drive(self.bodyTextView.rx.text)
            .disposed(by: self.bag)

        output.leftBarButtonText
            .drive(self.leftBarButton.rx.title)
            .disposed(by: self.bag)

        output.editable
            .drive(self.titleTextField.rx.isEnabled,
                   self.datePicker.rx.isEnabled,
                   self.bodyTextView.rx.isEditable)
            .disposed(by: self.bag)

        output.isValid
            .drive(self.rightBarButton.rx.isEnabled)
            .disposed(by: self.bag)
    }
}
