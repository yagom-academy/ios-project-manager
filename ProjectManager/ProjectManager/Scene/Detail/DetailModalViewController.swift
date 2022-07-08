//
//  DetailViewModalController.swift
//  ProjectManager
//
//  Created by 우롱차, 파프리 on 06/07/2022.
//

import UIKit

protocol DetailViewControllerDelegate: AnyObject {
    func taskUpdate(task: Task)
}

class DetailModalViewController: UIViewController {
    let modalView: DetailModalView
    weak var delegate: DetailViewControllerDelegate?
    
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
        print("Done: right Button click")
        delegate?.taskUpdate(task: modalView.task)
        dismiss(animated: true)
    }
}
