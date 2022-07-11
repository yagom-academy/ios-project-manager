//
//  DetailViewModalController.swift
//  ProjectManager
//
//  Created by 우롱차, 파프리 on 06/07/2022.
//

import UIKit

protocol DetailViewControllerDelegate: AnyObject {
    func addTask(_ task: Task)
}

class DetailModalViewController: UIViewController {
    let modalView: DetailModalView
    let task: Task?
    weak var delegate: DetailViewControllerDelegate?
    
    init(modalView: DetailModalView, task: Task? = nil) {
        self.modalView = modalView
        self.task = task
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        if let task = task {
            modalView.setLabel(task: task)
        }
        view = modalView
    }
}

extension DetailModalViewController: ButtonActionDelegate {
    func cancelButtonClicked() {
        dismiss(animated: true)
    }
    
    func doneButtonClicked() {
        delegate?.addTask(modalView.task)
        dismiss(animated: true)
    }
}
