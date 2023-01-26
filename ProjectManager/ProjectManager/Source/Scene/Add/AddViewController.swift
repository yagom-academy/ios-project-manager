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
        setUpTopLeftButton(mode: dataManagementMode)
        setUpTopRightButton(mode: dataManagementMode)
    }
    
    private func setUpTopLeftButton(mode: DataManagementMode) {
        switch mode {
        case .create:
            customPopUpView.configureTopButtonText(left: MainNameSpace.cancel)
            customPopUpView.topLeftButton.addTarget(
                self,
                action: #selector(didTapCancelButton),
                for: .touchDown
            )
        case .edit:
            customPopUpView.configureTopButtonText(left: MainNameSpace.cancel)
            customPopUpView.topLeftButton.addTarget(
                self,
                action: #selector(didTapEditButton),
                for: .touchDown
            )
        case .read:
            customPopUpView.configureTopButtonText(left: MainNameSpace.edit)
            customPopUpView.topLeftButton.addTarget(
                self,
                action: #selector(didTapEditButton),
                for: .touchDown
            )
        }
    }
    
    private func setUpTopRightButton(mode: DataManagementMode) {
        switch mode {
        case .create:
            customPopUpView.configureTopButtonText(right: MainNameSpace.done)
        case .edit:
            customPopUpView.configureTopButtonText(right: MainNameSpace.save)
        case .read:
            customPopUpView.configureTopButtonText(right: MainNameSpace.close)
        }
        customPopUpView.topRightButton.addTarget(
            self,
            action: #selector(didTapDoneButton),
            for: .touchDown
        )
    }
    
//    private func setUpCancelButton() {
//        customPopUpView.cancelButton.addTarget(
//            self,
//            action: #selector(didTapCancelButton),
//            for: .touchDown
//        )
//    }
    
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
        let alert = createAlert(
            title: NameSpace.editButtonAlertTitle,
            message: NameSpace.editButtonAlertMessage
        )
        let firstAlertAction = createAlertAction(
            title: NameSpace.editButtonFirstAlertActionTitle
        ) { [self] in
            dataManagementMode = .edit
            customPopUpView.checkDataAccess(mode: dataManagementMode)
            setUpTopLeftButton(mode: dataManagementMode)
            setUpTopRightButton(mode: dataManagementMode)
        }
        let secondAlertAction = createAlertAction(
            title: NameSpace.editButtonSecondAlertActionTitle
        ) {}
        
        alert.addAction(firstAlertAction)
        alert.addAction(secondAlertAction)
        
        present(alert, animated: true)
    }
    
    @objc
    private func didTapCancelButton() {
        dismiss(animated: true)
    }
}

// MARK: - AlertPresentable

extension AddViewController: AlertPresentable {}

// MARK: - NameSpace

private enum NameSpace {
    static let editButtonAlertTitle = "모드전환"
    static let editButtonAlertMessage = "프로젝트 정보를 편집하시겠습니까?"
    static let editButtonFirstAlertActionTitle = "편집"
    static let editButtonSecondAlertActionTitle = "취소"
}
