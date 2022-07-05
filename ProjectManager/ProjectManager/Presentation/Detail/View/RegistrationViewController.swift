//
//  UpdateViewController.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/05.
//

import UIKit

final class RegistrationViewController: UIViewController {
    private let registrationView = ModalView(frame: .zero)
    
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
        dismiss(animated: true, completion: nil)
    }
}
