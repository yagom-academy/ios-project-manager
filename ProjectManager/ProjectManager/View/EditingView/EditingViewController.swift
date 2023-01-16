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
        textView.addShadow(backGroundColor: .white, shadowColor: .black)
        
        return textView
    }()
    
    private let stack = UIStackView(axis: .vertical, spacing: Default.stackSpacing)
    
    init(viewModel: EditingViewModel) {
        self.editViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
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
}

// MARK: - NavigationBar
extension EditingViewController {
    
    private func setupNavigationBar() {
        let navigationBar = UINavigationBar(frame: CGRect(x: Default.origin,
                                                          y: Default.origin,
                                                          width: view.frame.width,
                                                          height: Default.navigationBarHeight))
        let navigationItem = UINavigationItem()
        navigationItem.title = editViewModel.barTitle
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "cancel",
                                                           primaryAction: touchedUpCancelButton())
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done",
                                                            primaryAction: touchedUpDoneButton())
        navigationBar.items = [navigationItem]
        navigationBar.isTranslucent = false
        view.addSubview(navigationBar)
    }
    
    private func touchedUpCancelButton() -> UIAction {
        return UIAction { [weak self] _ in
            self?.dismiss(animated: true)
        }
    }
    
    private func touchedUpDoneButton() -> UIAction {
        return UIAction { [weak self] _ in
            guard let self = self else { return }
            
            self.editViewModel.doneEditing(titleInput: self.titleField.text,
                                           descriptionInput: self.descriptionTextView.text,
                                           dateInput: self.dataPicker.date)
            
            self.dismiss(animated: true)
        }
    }
}

// MARK: - Layout
extension EditingViewController {
    private func configureHierarchy() {
        [titleField, dataPicker, descriptionTextView].forEach {
            stack.addArrangedSubview($0)
        }
        
        view.addSubview(stack)
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            descriptionTextView.heightAnchor.constraint(equalTo: stack.heightAnchor,
                                                        multiplier: Default.descriptionHeightRatio),
            dataPicker.heightAnchor.constraint(equalTo: stack.heightAnchor,
                                               multiplier: Default.dataPickerHeightRatio),
            stack.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
                                           constant: Default.margin),
            stack.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,
                                            constant: -Default.margin),
            stack.topAnchor.constraint(equalTo: safeArea.topAnchor,
                                       constant: Default.stackTopMargin),
            stack.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,
                                          constant: -Default.margin)
        ])
    }
}

extension EditingViewController {
    
    private enum Default {
        
        static let titlePlaceHolder = "Title"
        static let radius: CGFloat = 10
        static let titlePadding: CGFloat = 20
        static let stackSpacing: CGFloat = 10
        static let origin: CGFloat = 0
        static let navigationBarHeight: CGFloat = 70
        static let descriptionHeightRatio = 0.4
        static let titleHeightRatio = 0.15
        static let dataPickerHeightRatio = 1 - descriptionHeightRatio - titleHeightRatio
        static let margin: CGFloat = 10
        static let stackTopMargin = navigationBarHeight + margin
    }
}
