//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class MainViewController: UIViewController {
    private lazy var mainView = MainView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        navigationItem.title = "Project Manager"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addButtonClick(_:)) )
    }
    
    @objc
    private func addButtonClick(_ sender: Any) {
        let detailView = DetailModalView(frame: view.bounds)
        let detailModalViewController = DetailModalViewController(modalView: detailView)
        detailView.setButtonDelegate(detailModalViewController)
        detailModalViewController.modalPresentationStyle = .formSheet
        self.present(detailModalViewController, animated: true)
    }
}
