//
//  RegisterViewController.swift
//  ProjectManager
//
//  Created by 써니쿠키 on 2023/01/13.
//

import UIKit

class EditingViewController: UIViewController {
    
    var viewModel: EditingViewModel
    
    let titleField: UITextField = {
        let field = UITextField(font: .headline, placeHolder: "Title")
        field.borderStyle = .roundedRect
        field.layer.cornerRadius = 10
        field.addShadow(backGroundColor: .white, shadowColor: .black)
        field.addPadding(width: 20)

        return field
    }()
    
    let dataPicker: UIDatePicker = {
        let dataPicker = UIDatePicker()
        dataPicker.datePickerMode = .date
        dataPicker.preferredDatePickerStyle = .wheels
        dataPicker.translatesAutoresizingMaskIntoConstraints = false
        
        return dataPicker
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView(font: .title2)
        textView.layer.cornerRadius = 10
        textView.addShadow(backGroundColor: .white, shadowColor: .black)
        
        return textView
    }()
    
    let stack = UIStackView(axis: .vertical, spacing: 10)
    
    init(viewModel: EditingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        bidingViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .systemBackground
        configureHierarchy()
        configureLayout()
        setupNavigationBar()
    }
    
    func bidingViewModel() {
        viewModel.updateData = { [weak self] project in
            self?.titleField.text = project.title
            self?.descriptionTextView.text = project.description
            self?.dataPicker.date = project.date
        }
    }
    
    func configureHierarchy() {
        [titleField, dataPicker, descriptionTextView].forEach {
            stack.addArrangedSubview($0)
        }

        view.addSubview(stack)
    }

    func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            descriptionTextView.heightAnchor.constraint(equalTo: stack.heightAnchor,
                                                        multiplier: 0.4),
            dataPicker.heightAnchor.constraint(equalTo: stack.heightAnchor, multiplier: 0.45),
            stack.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            stack.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
            stack.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 80),
            stack.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10)
        ])
    }
    
    func setupNavigationBar() {
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0,
                                                          width: view.frame.width, height: 70))
        let navigationItem = UINavigationItem(title: viewModel.processTitle)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "cancel",
                                                           primaryAction: touchedUpCancelButton())
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done",
                                                            primaryAction: touchedUpDoneButton())
        navigationBar.items = [navigationItem]
        navigationBar.isTranslucent = false
        view.addSubview(navigationBar)
    }
        
    func touchedUpCancelButton() -> UIAction {
        return UIAction { [weak self] _ in
            self?.dismiss(animated: true)
        }
    }
    
    func touchedUpDoneButton() -> UIAction {
        return UIAction { [weak self] _ in
            guard let self = self else { return }
            
            self.viewModel.doneEditing(titleInput: self.titleField.text,
                                       descriptionInput: self.descriptionTextView.text,
                                       dateInput: self.dataPicker.date)
            
            self.dismiss(animated: true)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
