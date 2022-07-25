//
//  AlertController.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/21.
//

import UIKit

final class AlertController: UIAlertController {
    init(over source: UIViewController, title: String, confirmButton: UIAlertAction? = nil) {
        super.init(nibName: nil, bundle: nil)
        
        setUp(alertTitle: title, confirmButton: confirmButton)
        setUpAttribute(over: source)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp(alertTitle: String, confirmButton: UIAlertAction?) {
        let cancelButton = UIAlertAction(title: "취소", style: .default)
        
        if let confirmButton = confirmButton {
            addAction(confirmButton)
        }
        addAction(cancelButton)
        
        title = alertTitle
    }
    
    private func setUpAttribute(over source: UIViewController) {
        if let popoverController = popoverPresentationController {
            popoverController.permittedArrowDirections = []
            popoverController.sourceView = source.view
            popoverController.sourceRect = CGRect(
                x: source.view.bounds.midX,
                y: source.view.bounds.midY,
                width: 0,
                height: 0
            )
        }
    }
}
