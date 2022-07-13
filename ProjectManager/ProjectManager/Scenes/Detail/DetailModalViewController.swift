//
//  DetailViewModalController.swift
//  ProjectManager
//
//  Created by 우롱차, 파프리 on 06/07/2022.
//

import UIKit

protocol DetailViewControllerDelegate: AnyObject {
    func addTask(_ task: Task)
    func updateTask(by taskInfo: TaskInfo)
}

class DetailModalViewController: UIViewController {
    private enum State {
        case add
        case edit
    }
    
    private let modalView: DetailModalView
    private var state: State
    private let taskInfo: TaskInfo?
    weak var delegate: DetailViewControllerDelegate?
    
    init(modalView: DetailModalView, taskInfo: TaskInfo? = nil) {
        self.modalView = modalView
        self.taskInfo = taskInfo
        state = taskInfo == nil ? .add : .edit
        super.init(nibName: nil, bundle: nil)
        modalView.setTextFieldDelegate(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        if let task = taskInfo?.task {
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
            guard let taskInfo = taskInfo else {
                return
            }
            delegate?.updateTask(by: TaskInfo(task: modalView.task,
                                              type: taskInfo.type,
                                              indexPath: taskInfo.indexPath))
        case .add:
            delegate?.addTask(modalView.task)
        }
        dismiss(animated: true)
    }
}

extension DetailModalViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        modalView.setLayoutTextViewDidBeginEditing()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        modalView.setLayoutTextViewDidEndEditing()
    }
}
