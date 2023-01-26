//
//  EditProjectViewController.swift
//  ProjectManager
//
//  Created by jin on 1/26/23.
//

import UIKit

class EditProjectViewController: AddProjectViewController {

    private var type: TaskStatus
    
    init(type: TaskStatus) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func configureNavigationItem() {
        navigationItem.title = type.rawValue
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: nil)
    }
}
