//
//  EditFormSheetViewController.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/07.
//

import UIKit
import RealmSwift

final class EditFormSheetViewController: UIViewController {
    
    private let editFormSheetView = FormSheetView()
    private let realm = try? Realm()
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
        dismiss(animated: true)
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
        
        do {
            try realm?.write {
                realm?.add(editProject, update: .modified)
            }
        } catch {
            print("업데이트를 실패하였습니다.")
        }
        delegate?.refreshData()
    }
}
