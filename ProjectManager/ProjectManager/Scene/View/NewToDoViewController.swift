//
//  NewToDoViewController.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/06.
//

import UIKit

final class NewToDoViewController: UIViewController {
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TODO"
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = doneButton
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: nil)
        navigationItem.leftBarButtonItem = cancelButton
    }
    
}
