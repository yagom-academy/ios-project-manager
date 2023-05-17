//
//  ProjectManager - AddProjectViewController.swift
//  Created by Rhode.
//  Copyright © yagom. All rights reserved.
//

import UIKit

class AddProjectViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemGray6
        title = "TODO"
        
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit,
                                             target: self,
                                             action: #selector(editProject))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                             target: self,
                                             action: #selector(doneEditingProject))
        navigationItem.leftBarButtonItem = editButton
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc
    private func editProject() {
        print("editProject")
    }
    
    @objc
    private func doneEditingProject() {
        print("doneEditingProject")
    }
}
