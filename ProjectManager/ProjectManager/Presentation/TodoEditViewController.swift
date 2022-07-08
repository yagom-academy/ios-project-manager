//
//  TodoEditViewController.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/08.
//

import UIKit
import SnapKit

class TodoEditViewController: UIViewController {
    private let mainView = TodoEditView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
}

//MARK: - View Setting
extension TodoEditViewController {
    private func configureView() {
        self.view.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
