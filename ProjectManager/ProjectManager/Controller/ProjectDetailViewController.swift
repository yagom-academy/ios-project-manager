//
//  ProjectDetailViewController.swift
//  ProjectManager
//
//  Created by 1 on 2022/03/07.
//

import UIKit

class ProjectDetailViewController: UIViewController {
    
    var project: Project?
    private var navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        return navigationBar
    }()
    
    override func loadView() {
        self.view = .init()
        self.view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        self.configureNavigationItem()
        self.configureNavigationBarLayout()
    }
    
    // MARK: - Configure View
    private func configureNavigationItem() {
        let navigationItem = UINavigationItem()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                        target: self,
                                        action: nil)
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit,
                                         target: self,
                                         action: nil)
        navigationItem.rightBarButtonItem = doneButton
        navigationItem.leftBarButtonItem = editButton
        
        navigationBar.items = [navigationItem]
    }
   
    private func configureNavigationBarLayout() {
        self.view.addSubview(navigationBar)
        let safeArea = self.view.safeAreaLayoutGuide
        navigationBar.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        navigationBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        navigationBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
    }
}
