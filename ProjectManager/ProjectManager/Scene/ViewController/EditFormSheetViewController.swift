//
//  EditFormSheetViewController.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/07.
//

import UIKit

final class EditFormSheetViewController: UIViewController {
    
    private let editFormSheetView = FormSheetView()
    private let realmManager = RealmManager()
    weak var delegate: DataReloadable?
    var task: Task?

    override func loadView() {
        super.loadView()
        view = editFormSheetView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBarItems()
        setupContents()
    }
    
    private func configureNavigationBarItems() {
        title = task?.taskType.value
        
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .plain,
            target: self,
            action: #selector(doneButtonTapped)
        )
        navigationItem.rightBarButtonItem = doneButton
        
        let editButton = UIBarButtonItem(
            title: "Edit",
            style: .plain,
            target: self,
            action: #selector(editButtonTapped)
        )
        navigationItem.leftBarButtonItem = editButton
    }
    
    @objc private func editButtonTapped() {
        editToTempModel()
        dismiss(animated: true) { [weak self] in
            self?.delegate?.refreshData()
        }
    }
    
    @objc private func doneButtonTapped() {
        dismiss(animated: true)
    }
    
    private func setupContents() {
        if let task = task {
            editFormSheetView.setUpContents(task: task)
        }
    }
    
    func editToTempModel() {
        guard let task = task else { return }
        
        let editProject = Task(
            title: editFormSheetView.titleTextField.text ?? "",
            body: editFormSheetView.bodyTextView.text ?? "",
            date: editFormSheetView.datePicker.date.timeIntervalSince1970,
            taskType: task.taskType,
            id: task.id
        )
        realmManager.update(task: editProject)
    }
}
