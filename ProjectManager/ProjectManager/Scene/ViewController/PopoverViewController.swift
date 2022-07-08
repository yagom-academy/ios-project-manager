//
//  PopoverViewController.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/08.
//

import UIKit

final class PopoverViewController: UIViewController {
    private let popoverView = PopoverView(frame: .zero)
    private let realmManager = RealmManager()
    weak var delegate: DataReloadable?
    var task: Task?
    
    override func loadView() {
        super.loadView()
        view = popoverView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargetButtons()
    }
    
    private func addTargetButtons() {
        popoverView.moveToToDoButton.addTarget(
            self,
            action: #selector(moveToToDo),
            for: .touchUpInside
        )
        popoverView.moveToDoingButton.addTarget(
            self,
            action: #selector(moveToDoing),
            for: .touchUpInside
        )
        popoverView.moveToDoneButton.addTarget(
            self,
            action: #selector(moveToDone),
            for: .touchUpInside
        )
    }
    
    func setPopoverAction() {
        guard let task = task else { return }
        switch task.taskType {
        case .todo:
            popoverView.moveToToDoButton.isHidden = true
        case .doing:
            popoverView.moveToDoingButton.isHidden = true
        case .done:
            popoverView.moveToDoneButton.isHidden = true
        }
    }
    
    @objc private func moveToToDo() {
        modifiedTaskType(taskType: .todo)
    }
    
    @objc private func moveToDoing() {
        modifiedTaskType(taskType: .doing)
    }
    
    @objc private func moveToDone() {
        modifiedTaskType(taskType: .done)
    }
    
    private func modifiedTaskType(taskType: TaskType) {
        guard let task = task else { return }
        realmManager.convert(task: task, taskType: taskType)
        dismiss(animated: true) { [weak self] in
            self?.delegate?.refreshData()
        }
    }
}
