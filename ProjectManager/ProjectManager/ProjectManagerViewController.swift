//
//  ProjectManager - ProjectManagerViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ProjectManagerViewController: UIViewController {

    let registerViewController = RegisterViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rightBarButton = UIBarButtonItem.init(barButtonSystemItem: .add,
                                                  target: self,
                                                  action: #selector(buttonPressed(_:)))
        
        view.backgroundColor = .white
        navigationItem.title = "Project Manager"
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func buttonPressed(_ sender: Any) {
        self.present(registerViewController, animated: true, completion: nil)
    }
}
