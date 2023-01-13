//  ProjectManager - MainViewController.swift
//  created by zhilly on 2023/01/11

import UIKit

class MainViewController: UIViewController {
    private enum Constant {
        static let title = "Project Manager"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        view.backgroundColor = .systemBackground
        title = Constant.title
        
        setupBarButtonItem()
    }
    
    private func setupBarButtonItem() {
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                             style: .plain,
                                             target: self,
                                             action: nil)
        
        navigationItem.setRightBarButton(rightBarButton, animated: true)
    }
}
