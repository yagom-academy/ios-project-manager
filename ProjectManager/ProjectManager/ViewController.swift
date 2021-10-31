//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import SwiftUI

class ViewController: UIViewController {

    @IBSegueAction func show(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: MainView())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

