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
    private let customPopUpView = CustomPopUpView()
    
    // MARK: Life Cycle
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = customPopUpView
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        setUpDoneButton()
    }
    
    // MARK: Private Methods
    
    func setUpDoneButton() {
        customPopUpView.doneButton.addTarget(
            self,
            action: #selector(didTapDismissButton),
            for: .touchDown
        )
    }
    
    // MARK: Action Methods
    
    @objc
    private func didTapDismissButton() {
        if let inputData: ProjectData = customPopUpView.saveProjectData() {
            delegate?.sendData(project: inputData)
        }
        
        dismiss(animated: true, completion: nil)
    }
}
