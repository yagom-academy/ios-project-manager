//
//  AddViewController.swift
//  ProjectManager
//
//  Created by yonggeun Kim on 2023/01/15.
//

import UIKit

class AddViewController: UIViewController {
    
    // MARK: Properties
    
    var delegate: DataSendable?
    var savedData: ProjectData?
    private let customPopUpView = CustomPopUpView()
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = customPopUpView
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        configureButtonAction()
        if let savedData = savedData {
            customPopUpView.showProjectData(with: savedData)
        }
    }
    
    // MARK: Private Methods
    
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
        if let userInputData: ProjectData = customPopUpView.saveProjectData() {
            delegate?.sendData(with: userInputData)
        }
        
        dismiss(animated: true)
    }
    
    @objc
    private func didTapEditButton() {
    }
    
    @objc
    private func didTapCancelButton() {
        dismiss(animated: true)
    }
}
