//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ProjectManagerViewController: UIViewController {
    private let projectManagerView = ProjectManagerView()
    
    override func loadView() {
        super.loadView()
        self.view = projectManagerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Project Manager"
    }

}
