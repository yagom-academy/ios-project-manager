//
//  AddViewController.swift
//  ProjectManager
//
//  Created by yonggeun Kim on 2023/01/15.
//

import UIKit

class AddViewController: UIViewController {
    
    // MARK: Properties
    
    private var popUpView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        configureLayout()
    }
    
    // MARK: Private Methods
    
    private func configureLayout() {
//        view.addSubview(popUpView)
    }
    
    // MARK: Action Methods
    
    @objc
    private func didTapDismissButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
