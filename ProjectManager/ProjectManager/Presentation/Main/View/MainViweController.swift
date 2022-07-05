//
//  MainViweController.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/04.
//

import UIKit

final class MainViweController: UIViewController {
    private let mainView = MainView(frame: .zero)
    
    override func loadView() {
        super.loadView()
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavigationItem()
    }
    
    private func setUpNavigationItem() {
        navigationItem.title = "Project Manager"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(presentDetailView)
        )
    }
    
    @objc func presentDetailView() {
        let next = UINavigationController(rootViewController: RegistrationViewController())
        
        next.modalPresentationStyle = .formSheet
        
        present(next, animated: true)
    }
}
