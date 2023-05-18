//
//  TodoViewController.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/18.
//

import UIKit

class TodoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.title = "TODO"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                           target: self,
                                                           action: #selector(didTapCancelButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                            target: self,
                                                            action: #selector(didTapDoneButton))
    }
    
    @objc private func didTapCancelButton() {
        self.dismiss(animated: true)
    }
    
    @objc private func didTapDoneButton() {
        self.dismiss(animated: true)
    }
}
