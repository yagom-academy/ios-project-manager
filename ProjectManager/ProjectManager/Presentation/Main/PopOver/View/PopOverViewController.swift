//
//  PopOverViewController.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/11.
//

import UIKit
import RxCocoa

protocol PopOverDelegate: AnyObject {
    func dismiss()
}

extension PopOverViewController: PopOverDelegate {
    func dismiss() {
        dismiss(animated: true)
    }
}

final class PopOverViewController: UIViewController {
    private lazy var popOverView = PopOverView(delegate: self)
    private let viewModel: PopOverViewModel
    
    init(cell: ProjectCell) {
        viewModel = PopOverViewModel(cell: cell)
        super.init(nibName: nil, bundle: nil)
        view = popOverView
        setUpAttribute(cell)
        setUpButtonAction(cell)
        setUpButtonTitle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpAttribute(_ cell: ProjectCell) {
        modalPresentationStyle = .popover
        popoverPresentationController?.sourceView = cell
        preferredContentSize = CGSize(width: 300, height: 100)
        popoverPresentationController?.permittedArrowDirections = .up
        popoverPresentationController?
            .sourceRect = CGRect(
                x: cell.bounds.width * 0.5,
                y: cell.bounds.minY,
                width: 30,
                height: 50
            )
    }
    
    private func setUpButtonTitle() {
        guard let (first, second) = viewModel.getStatus() else {
            return
        }
        
        popOverView.setUpButtonTitle(first: first, second: second)
    }
    
    private func setUpButtonAction(_ cell: ProjectCell) {
        popOverView.addButtonAction(cell)
    }
}
