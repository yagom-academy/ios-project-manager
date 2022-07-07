//
//  RegistrationViewController.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/05.
//

import UIKit

final class RegistrationViewController: UIViewController {
    private let registrationView = ModalView(frame: .zero)
    private let viewModel: MainViewModel
        
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = registrationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationItem()
    }
    
    private func setUpNavigationItem() {
        navigationItem.title = "TODO"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelRegistration)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(saveRegistration)
        )
    }
    
    @objc func cancelRegistration() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func saveRegistration() {
        var array = viewModel.toDoTableProjects.value
        
        array.append(ProjectContent(ProjectItem(title: registrationView.titleTextField.text!, deadline: registrationView.datePicker.date, description: registrationView.descriptionTextView.text!)))
        
        viewModel.toDoTableProjects.accept(array)
        
        dismiss(animated: true, completion: nil)
    }
}
