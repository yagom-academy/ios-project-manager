//
//  AddViewController.swift
//  ProjectManager
//
//  Created by yonggeun Kim on 2023/01/15.
//

import UIKit

enum DataManagementMode {
    case create
    case edit
    case read
}

final class AddViewController: UIViewController {
    
    // MARK: Internal Properties
    
    var delegate: DataSendable?
    var savedData: ProjectData?
    var dataManagementMode: DataManagementMode = .read
    var dataSection: Section = .todo
    
    // MARK: Private Properties
    
    private let customPopUpView = CustomPopUpView()
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = customPopUpView
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        configureButtonAction()
        customPopUpView.checkDataAccess(mode: dataManagementMode)
        checkSavedData(with: savedData)
    }
    
    // MARK: Private Methods
    
    private func checkSavedData(with data: ProjectData?) {
        if let savedData = data {
            customPopUpView.showProjectData(with: savedData)
        }
    }
    
    private func configureButtonAction() {
        setUpDoneButton()
        setUpEditButton()
        setUpCancelButton()
    }
    
    private func setUpDoneButton() {
        customPopUpView.doneButton.addTarget(
            self,
            action: #selector(didTapDoneButton),
            for: .touchDown
        )
    }
    
    private func setUpEditButton() {
        customPopUpView.editButton.addTarget(
            self,
            action: #selector(didTapEditButton),
            for: .touchDown
        )
    }
    
    private func setUpCancelButton() {
        customPopUpView.cancelButton.addTarget(
            self,
            action: #selector(didTapCancelButton),
            for: .touchDown
        )
    }
    
    // MARK: Action Methods
    
    @objc
    private func didTapDoneButton() {
        switch dataManagementMode {
        case .create:
            if let userInputData: ProjectData = customPopUpView.saveProjectData() {
                delegate?.sendData(with: userInputData, mode: .create, section: .todo)
            }
        case . edit:
            if let userInputData: ProjectData = customPopUpView.saveProjectData() {
                delegate?.sendData(with: userInputData, mode: .edit, section: dataSection)
            }
        case .read:
            break
        }
        
        dismiss(animated: true)
    }
    
    @objc
    private func didTapEditButton() {
        dataManagementMode = .edit
        customPopUpView.checkDataAccess(mode: dataManagementMode)
    }
    
    @objc
    private func didTapCancelButton() {
        dismiss(animated: true)
    }
}
