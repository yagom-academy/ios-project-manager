//
//  PopoverViewController.swift
//  ProjectManager
//
//  Created by 우롱차, 파프리 on 12/07/2022.
//

import UIKit

class PopoverViewController: UIViewController {
    private lazy var mainView = PopoverView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
