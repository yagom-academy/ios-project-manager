//
//  PopoverViewController.swift
//  ProjectManager
//
//  Created by 우롱차, 파프리 on 12/07/2022.
//

import UIKit
import SwiftUI

protocol PopoverViewControllerDelegate: AnyObject {
    func moveToToDo(taskInfo: TaskInfo)
    func moveToDoing(taskInfo: TaskInfo)
    func moveToDone(taskInfo: TaskInfo)
}

class PopoverViewController: UIViewController {
    private let mainView = PopoverView()
    private let taskInfo: TaskInfo
    weak var delegate: PopoverViewControllerDelegate?
    
    init(taskInfo: TaskInfo) {
        self.taskInfo = taskInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
        setButtonTarget()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension PopoverViewController {
    
    func setButtonTarget() {
        mainView.findButton(taskType: .todo)
                .addTarget(self, action: #selector(moveToToDoButtonClicked), for: .touchUpInside)
        mainView.findButton(taskType: .doing)
                .addTarget(self, action: #selector(moveToDoingButtonClicked), for: .touchUpInside)
        mainView.findButton(taskType: .done)
                .addTarget(self, action: #selector(moveToDoneButtonClicked), for: .touchUpInside)
    }
    
    @objc func moveToToDoButtonClicked() {
        delegate?.moveToToDo(taskInfo: taskInfo)
        dismiss(animated: true)
    }
    
    @objc func moveToDoingButtonClicked() {
        delegate?.moveToDoing(taskInfo: taskInfo)
        dismiss(animated: true)
    }
    
    @objc func moveToDoneButtonClicked() {
        delegate?.moveToDone(taskInfo: taskInfo)
        dismiss(animated: true)
    }
}
