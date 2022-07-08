//
//  NewFormSheetViewController.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/06.
//

import UIKit
import RealmSwift

final class NewFormSheetViewController: UIViewController {
    
    private let newFormSheetView = FormSheetView()
    private let realm = try? Realm()
    private let uuid = UUID().uuidString
    
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
    }
    
    func saveToTempModel() {
        let newProject = Task(
            title: newFormSheetView.titleTextField.text ?? "",
            body: newFormSheetView.bodyTextView.text ?? "",
            date: newFormSheetView.datePicker.date.timeIntervalSince1970,
            taskType: .todo,
            id: uuid
        )
        
        do {
            try realm?.write {
                realm?.add(newProject)
            }
        } catch {
            print("중복된 내용입니다.")
        }
        dismiss(animated: true)
    }
}
