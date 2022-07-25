//
//  AlertController.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/21.
//

import UIKit

final class AlertController: UIAlertController {
    init(title: String) {
        super.init(nibName: nil, bundle: nil)
        
        setUp(alertTitle: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp(alertTitle: String) {
        title = alertTitle
        let cacel = UIAlertAction(title: "확인", style: .cancel)
        addAction(cacel)
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
