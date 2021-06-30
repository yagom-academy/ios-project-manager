//
//  RegisterViewController.swift
//  ProjectManager
//
//  Created by YB on 2021/06/29.
//

import UIKit

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationItem.title = "TODO"

        let leftButton = UIBarButtonItem.init(title: "Cancel", style: .done, target: self, action: nil)
        let rightButton = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: nil)

        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rightButton
        
        
    }
}
