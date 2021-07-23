//
//  TaskFormViewController.swift
//  ProjectManager
//
//  Created by steven on 7/23/21.
//

import UIKit

class TaskFormViewController: UIViewController {
    var type: String?
    
    convenience init() {
        print("convenience init")
        self.init(type: nil)
    }
    
    init(type: String?) {
        print("init")
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // leftbutton
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "cancel", style: .plain, target: self, action: nil)
        // rightbutton
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "done", style: .plain, target: self, action: nil)
        
        self.navigationItem.title = "TODO"
        
        self.view.backgroundColor = .systemBackground
    }
    
}
