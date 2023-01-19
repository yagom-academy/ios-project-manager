//
//  RegisterViewController.swift
//  ProjectManager
//
//  Created by 써니쿠키 on 2023/01/13.
//

import UIKit

final class EditingViewController: UIViewController {
    
    private var editViewModel: EditingViewModel
    
    private let titleField: UITextField = {
        let field = UITextField(font: .headline, placeHolder: Default.titlePlaceHolder)
        field.borderStyle = .roundedRect
        field.layer.cornerRadius = Default.radius
        field.addShadow(backGroundColor: .white, shadowColor: .black)
        field.addPadding(width: Default.titlePadding)
        
        return field
    }()
    
    private let dataPicker: UIDatePicker = {
        let dataPicker = UIDatePicker()
        dataPicker.datePickerMode = .date
        dataPicker.preferredDatePickerStyle = .wheels
        dataPicker.translatesAutoresizingMaskIntoConstraints = false
        
        return dataPicker
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView(font: .title2)
        textView.layer.cornerRadius = Default.radius
        textView.keyboardDismissMode = .interactive
        textView.addShadow(backGroundColor: .white, shadowColor: .black)
        
        return textView
    }()
    
    private let stackView = UIStackView(axis: .vertical)
    
    init(viewModel: EditingViewModel) {
        self.editViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        addKeyboardNotifications()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bidingViewModel()
        editViewModel.initialSetupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .systemBackground
        configureHierarchy()
        configureLayout()
        setupNavigationBar()
    }
    
    private func bidingViewModel() {
        editViewModel.changeMode = { [weak self] in
            self?.toggleMode()
            self?.setupNavigationBar()
        }
        
        editViewModel.updateTitle = { [weak self] title in
            self?.titleField.text = title
        }
        
        editViewModel.updateDate = { [weak self] date in
            self?.dataPicker.date = date
        }
        
        editViewModel.updateDescription = { [weak self] description in
            self?.descriptionTextView.text = description
        }
    }
    
    private func toggleMode() {
        titleField.isUserInteractionEnabled = !titleField.isUserInteractionEnabled
        descriptionTextView.isUserInteractionEnabled = !descriptionTextView.isUserInteractionEnabled
        dataPicker.isUserInteractionEnabled = !dataPicker.isUserInteractionEnabled
    }
}

// MARK: - NavigationBar
extension EditingViewController {
    
    private func setupNavigationBar() {
        let navigationBar = UINavigationBar(frame: CGRect(x: Default.origin,
                                                          y: Default.origin,
                                                          width: view.frame.width,
                                                          height: Default.navigationBarHeight))
        let navigationItem = generateNavigationItem()
        navigationBar.items = [navigationItem]
        navigationBar.isTranslucent = false
        
        view.addSubview(navigationBar)
    }
    
    func generateNavigationItem() -> UINavigationItem {
        let navigationItem = UINavigationItem()
        let leftBarButton = UIBarButtonItem(title: editViewModel.leftBarOptionTitle)
        let rightBarButton = UIBarButtonItem(title: editViewModel.rightBarOptionTitle)
        
        leftBarButton.action = editViewModel.isEditable ?
        #selector(cancelEditing) : #selector(changeModeToEditable)
        
        rightBarButton.action = #selector(doneEditing)
        
        navigationItem.title = editViewModel.barTitle
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = rightBarButton
        
        return navigationItem
    }
    
    @objc private func changeModeToEditable() {
        editViewModel.changeModeToEditable()
        descriptionTextView.becomeFirstResponder()
    }
    
    @objc private func cancelEditing() {
        dismiss(animated: true)
        descriptionTextView.resignFirstResponder()
    }
    
    @objc private func doneEditing() {
        editViewModel.doneEditing(titleInput: self.titleField.text,
                                  descriptionInput: self.descriptionTextView.text,
                                  dateInput: self.dataPicker.date)
        
        descriptionTextView.resignFirstResponder()
        dismiss(animated: true)
    }
}

// MARK: - Layout
extension EditingViewController {
    private func configureHierarchy() {
        [titleField, dataPicker, descriptionTextView].forEach { stackView.addArrangedSubview($0) }
        
        view.addSubview(stackView)
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            titleField.heightAnchor.constraint(greaterThanOrEqualTo: stackView.heightAnchor,
                                               multiplier: Default.titleHeightRatio),
            
            descriptionTextView.heightAnchor.constraint(greaterThanOrEqualTo:
                                                            stackView.heightAnchor,
                                                        multiplier:
                                                            Default.descriptionHeightRatio),
            
            dataPicker.heightAnchor.constraint(lessThanOrEqualTo: stackView.heightAnchor,
                                               multiplier: Default.dataPickerHeightRatio),
            
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
                                               constant: Default.margin),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,
                                                constant: -Default.margin),
            stackView.topAnchor.constraint(equalTo: safeArea.topAnchor,
                                           constant: Default.stackTopMargin),
            stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,
                                              constant: -Default.margin)
        ])
    }
}

// MARK: - HandlingKeyBoard
extension EditingViewController {
    private func addKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(setKeyboardShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(setKeyboardHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc private func setKeyboardShow(_ notification: Notification) {
        guard let containerHeight = presentationController?.containerView?.frame.height,
              containerHeight/2 < view.frame.height else { return }
        
        view.frame = CGRect(x: Default.origin, y: Default.origin,
                            width: view.frame.width, height: view.frame.height/2)
    }
    
    @objc private func setKeyboardHide(_ notification: Notification) {
        guard let containerHeight = presentationController?.containerView?.frame.height,
              containerHeight/2 > view.frame.height else { return }
        
        view.frame = CGRect(x: Default.origin, y: Default.origin,
                            width: view.frame.width, height: view.frame.height * 2)
    }
}

// MARK: - NameSpace
extension EditingViewController {
    
    private enum Default {
        
        static let titlePlaceHolder = "Title"
        static let radius: CGFloat = 10
        static let titlePadding: CGFloat = 20
        static let origin: CGFloat = 0
        static let navigationBarHeight: CGFloat = 70
        static let descriptionHeightRatio = 0.4
        static let titleHeightRatio = 0.1
        static let dataPickerHeightRatio = 1 - descriptionHeightRatio - titleHeightRatio
        static let margin: CGFloat = 10
        static let stackTopMargin = navigationBarHeight
    }
}
