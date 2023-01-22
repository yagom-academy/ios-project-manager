//
//  RegisterViewController.swift
//  ProjectManager
//
//  Created by 써니쿠키 on 2023/01/13.
//

import UIKit

final class EditingViewController: UIViewController {
    
    private var projectViewModel: ProjectViewModel
    private var editMode: EditingMode
    
    private let titleField: UITextField = {
        let field = UITextField(font: .headline, placeHolder: Default.titlePlaceHolder)
        field.borderStyle = .roundedRect
        field.layer.cornerRadius = Default.radius
        field.addShadow(backGroundColor: .white, shadowColor: .black)
        field.addPadding(width: Default.titlePadding)
        
        return field
    }()
    
    private let datePicker: UIDatePicker = {
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
        
        return textView
    }()
    
    private let stackView = UIStackView(axis: .vertical)
    
    init(projectViewModel: ProjectViewModel, editMode: EditingMode) {
        self.projectViewModel = projectViewModel
        self.editMode = editMode
        super.init(nibName: nil, bundle: nil)
        addKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureHierarchy()
        configureLayout()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }
    
    private func setupView() {
        titleField.text = projectViewModel.project.title
        datePicker.date = projectViewModel.project.date
        descriptionTextView.text = projectViewModel.project.description
        
        if editMode == .readOnly {
            makeReadOnlyModeView()
        }
    }
    
    private func editProject() {
        projectViewModel.project.title = titleField.text
        projectViewModel.project.date = datePicker.date
        projectViewModel.project.description = descriptionTextView.text
    }
    
    private func makeReadOnlyModeView() {
        [titleField, datePicker, descriptionTextView].forEach { view in
            view.isUserInteractionEnabled = false
        }
    }
    
    private func makeEditableModeView() {
        [titleField, datePicker, descriptionTextView].forEach { view in
            view.isUserInteractionEnabled = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        navigationItem.title = projectViewModel.state.title
        
        let leftBarButton = UIBarButtonItem(title: editMode.barOptionTitle.left)
        leftBarButton.action = editMode == .editable ?
        #selector(cancelEditing) : #selector(changeModeToEditable)
        
        let rightBarButton = UIBarButtonItem(title: editMode.barOptionTitle.right)
        rightBarButton.action = #selector(doneEditing)
        
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = rightBarButton
        
        return navigationItem
    }
    
    @objc private func changeModeToEditable() {
        editMode = .editable
        makeEditableModeView()
        descriptionTextView.becomeFirstResponder()
    }
    
    @objc private func cancelEditing() {
        dismiss(animated: true)
        descriptionTextView.resignFirstResponder()
    }
    
    @objc private func doneEditing() {
        editProject()
        descriptionTextView.resignFirstResponder()
        dismiss(animated: true)
        
        NotificationCenter.default.post(name: Notification.Name("editingDone"),
                                        object: nil,
                                        userInfo: ["project": projectViewModel.project,
                                                   "state": projectViewModel.state])
    }
}

// MARK: - Layout
extension EditingViewController {
    private func configureHierarchy() {
        [titleField, datePicker, descriptionTextView].forEach { view in
            stackView.addArrangedSubview(view) }
        
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
            
            datePicker.heightAnchor.constraint(lessThanOrEqualTo: stackView.heightAnchor,
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

extension EditingViewController {
    enum EditingMode {
        case editable
        case readOnly
        
        var barOptionTitle: (left: String, right: String) {
            switch self {
            case .editable:
                return (left: Title.Cancel, right: Title.Done)
            case .readOnly:
                return (left: Title.Edit, right: Title.Done)
            }
        }
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
    
    private enum Title {
        
        static let Cancel = "Cancel"
        static let Done = "Done"
        static let Edit = "Edit"
    }
}
