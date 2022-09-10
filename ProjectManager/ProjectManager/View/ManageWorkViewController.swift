//
//  ManageWorkViewController.swift
//  ProjectManager
//
//  Created by Judy on 2022/09/09.
//

import UIKit

class ManageWorkViewController: UIViewController {
    private let workManageView = WorkManageView()
    
    override func loadView() {
        super.loadView()
        self.view = workManageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "TODO"
        configureBarButton()
    }
    
    private func configureBarButton() {
        let cancleBarButton = UIBarButtonItem(title: "Cancle",
                                              style: .plain,
                                              target: self,
                                              action: #selector(cancelBarButtonTapped))
        let doneBarButton = UIBarButtonItem(title: "Done",
                                            style: .done,
                                            target: self,
                                            action: #selector(cancelBarButtonTapped))
        self.navigationItem.leftBarButtonItem = cancleBarButton
        self.navigationItem.rightBarButtonItem = doneBarButton
    }
    
    @objc private func cancelBarButtonTapped() {
        self.dismiss(animated: true)
    }
    
    func configureWork(_ work: Work) {
        workManageView.work.onNext(work)
    }
}
