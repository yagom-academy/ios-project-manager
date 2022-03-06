//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ProjectBoardViewController: UIViewController {
    
    // MARK: - Property
    private var navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        return navigationBar
    }()
    
    // MARK: - View Life Cycle
    override func loadView() {
        self.view = .init()
        self.view.backgroundColor = .systemGray3
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.delegate = self
        self.configureNavigationItem()
        self.configureNavigationBarLayout()
    }
     
    // MARK: - Configure View
    private func configureNavigationItem() {
        let navigationItem = UINavigationItem(title: "Project Manager")
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        navigationItem.rightBarButtonItem = addButton
        
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

// MARK: - UINavigationBarDelegate
extension ProjectBoardViewController: UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.topAttached
    }
}
