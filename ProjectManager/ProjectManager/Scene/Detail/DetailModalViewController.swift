//
//  DetailViewModalController.swift
//  ProjectManager
//
//  Created by 우롱차, 파프리 on 06/07/2022.
//

import UIKit

protocol DetailViewControllerDelegate: AnyObject {
    func addTask(_ task: Task)
    func editTask(task: Task, locationInfo: LocationInfo)
}

class DetailModalViewController: UIViewController {
    private enum State {
        case add
        case edit
    }
    
    private let modalView: DetailModalView
    private let task: Task?
    private var state: State
    private let locationInfo: LocationInfo?
    weak var delegate: DetailViewControllerDelegate?
    
    init(modalView: DetailModalView, task: Task? = nil, locationInfo: LocationInfo? = nil) {
        self.modalView = modalView
        self.task = task
        self.locationInfo = locationInfo
        state = task == nil ? .add : .edit
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
        switch state {
        case .edit:
            guard let locationInfo = locationInfo else {
                return
            }
            delegate?.editTask(task: modalView.task, locationInfo: locationInfo)
        case .add:
            delegate?.addTask(modalView.task)
        }
        dismiss(animated: true)
    }
}
