//
//  DetailViewModalController.swift
//  ProjectManager
//
//  Created by 우롱차, 파프리 on 06/07/2022.
//

import UIKit

class DetailModalViewController: UIViewController {
    let modalView: DetailModalView
    
    init(modalView: DetailModalView) {
        self.modalView = modalView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = modalView
    }
    
    override func viewDidLoad() {
    }
}

extension DetailModalViewController: ButtonActionDelegate {
    func topLeftButtonClicked() {
        print("left Button click")
    }
    
    func topRightButtonClicked() {
        print("right Button click")
    }
}
