//
//  PopOverViewController.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/11.
//

import UIKit

final class PopOverViewController: UIViewController {
    private let popOverView = PopOverView()
    
    init(cell: ProjectCell) {
        super.init(nibName: nil, bundle: nil)
        view = popOverView
        setUpAttribute(cell)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpAttribute(_ cell: ProjectCell) {
        modalPresentationStyle = .popover
        popoverPresentationController?.sourceView = cell
        preferredContentSize = .init(width: 300, height: 100)
        popoverPresentationController?.permittedArrowDirections = .up
        popoverPresentationController?
            .sourceRect = CGRect(
                x: cell.bounds.width * 0.5,
                y: cell.bounds.minY,
                width: 30,
                height: 50
            )
    }
}
