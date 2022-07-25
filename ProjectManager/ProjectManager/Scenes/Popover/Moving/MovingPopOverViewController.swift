//
//  MovingPopOverViewController.swift
//  ProjectManager
//
//  Created by 우롱차, 파프리 on 12/07/2022.
//

import UIKit

protocol PopoverViewControllerDelegate: AnyObject {
    func move(from: TaskInfo, to: TaskType)
}

class MovingPopOverViewController: UIViewController {
    private let mainView = MovingPopOverView()
    private let taskInfo: TaskInfo
    weak var delegate: PopoverViewControllerDelegate?
    
    init(taskInfo: TaskInfo) {
        self.taskInfo = taskInfo
        mainView.hideButton(taskType: taskInfo.type)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonTarget()
    }
}

// MARK: Functions

extension MovingPopOverViewController {
    func setButtonTarget() {
        mainView.findButton(taskType: .todo)
                .addTarget(self, action: #selector(moveToToDoButtonClicked), for: .touchUpInside)
        mainView.findButton(taskType: .doing)
                .addTarget(self, action: #selector(moveToDoingButtonClicked), for: .touchUpInside)
        mainView.findButton(taskType: .done)
                .addTarget(self, action: #selector(moveToDoneButtonClicked), for: .touchUpInside)
    }
    
    @objc func moveToToDoButtonClicked() {
        delegate?.move(from: taskInfo, to: .todo)
        dismiss(animated: true)
    }
    
    @objc func moveToDoingButtonClicked() {
        delegate?.move(from: taskInfo, to: .doing)
        dismiss(animated: true)
    }
    
    @objc func moveToDoneButtonClicked() {
        delegate?.move(from: taskInfo, to: .done)
        dismiss(animated: true)
    }
}
