//
//  NewFormSheetViewController.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/06.
//

import UIKit

final class NewFormSheetViewController: UIViewController {
    
    private let newFormSheetView = FormSheetView()
    private let realmManager = RealmManager()
    private let uuid = UUID().uuidString
    weak var delegate: DataReloadable?
    
    override func loadView() {
        super.loadView()
        view = newFormSheetView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBarItems()
    }
    
    private func configureNavigationBarItems() {
        title = "TODO"
        
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .plain,
            target: self,
            action: #selector(doneButtonTapped)
        )
        navigationItem.rightBarButtonItem = doneButton
        
        let cancelButton = UIBarButtonItem(
            title: "Cancel",
            style: .plain,
            target: self,
            action: #selector(cancelButtonTapped)
        )
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func doneButtonTapped() {
        saveToTempModel()
        dismiss(animated: true) { [weak self] in
            self?.delegate?.refreshData()
        }
    }
    
    func saveToTempModel() {
        let newProject = Task(
            title: newFormSheetView.titleTextField.text ?? "",
            body: newFormSheetView.bodyTextView.text ?? "",
            date: newFormSheetView.datePicker.date.timeIntervalSince1970,
            taskType: .todo,
            id: uuid
        )
        realmManager.create(task: newProject)
    }
}
