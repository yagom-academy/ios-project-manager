//
//  AddViewController.swift
//  ProjectManager
//
//  Created by yonggeun Kim on 2023/01/15.
//

import UIKit

class AddViewController: UIViewController {
    
    // MARK: Properties
    
    private let customPopUpView = CustomPopUpView()
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = customPopUpView
        view.backgroundColor = UIColor.white.withAlphaComponent(0.8)
    }
    
    // MARK: Private Methods
    
    // MARK: Action Methods
    
    @objc
    private func didTapDismissButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
