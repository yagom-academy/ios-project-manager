//
//  RegisterViewController.swift
//  ProjectManager
//
//  Created by 써니쿠키 on 2023/01/13.
//

import UIKit

class EditingViewController: UIViewController {
    let process: Process
    
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
    
    init(process: Process) {
        self.process = process
        super.init(nibName: nil, bundle: nil)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureHierarchy()
        configureLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
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
        let navigationItem = UINavigationItem(title: process.title)
        let doneAction = UIAction { _ in
            // 구현예정
            print("등록버튼 클릭")
        }
        let cancelAction = UIAction { _ in
            // 구현예정
            print("취소버튼 클릭")
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "cancel",
                                                           primaryAction: cancelAction)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done",
                                                            primaryAction: doneAction)
        navigationBar.items = [navigationItem]
        navigationBar.isTranslucent = false
        view.addSubview(navigationBar)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
