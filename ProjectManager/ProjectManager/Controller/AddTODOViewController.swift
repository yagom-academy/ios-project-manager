//
//  AddTODOViewController.swift
//  ProjectManager
//
//  Created by 1 on 2023/09/26.
//

import UIKit

final class AddTODOViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViewController()
        setUpBarButtonItem()
    }
    
    private func setUpViewController() {
        view.backgroundColor = .systemBackground
        title = "TODO"
    }
    
    private func setUpBarButtonItem() {
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButton))
        navigationItem.rightBarButtonItem = doneButton
        
        let cancel = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancelButton))
        navigationItem.leftBarButtonItem = cancel
    }
    
    @objc private func doneButton() {
        dismiss(animated: true)
    }
    
    @objc private func cancelButton() {
        dismiss(animated: true)
    }
}
