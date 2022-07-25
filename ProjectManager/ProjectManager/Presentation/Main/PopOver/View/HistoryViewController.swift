//
//  HistoryViewController.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/25.
//

import UIKit

final class HistoryViewController: UIViewController {
    private let historyView = HistoryView()
    private let viewModel = HistoryViewModel()
    
    init(source: UIBarButtonItem) {
        super.init(nibName: nil, bundle: nil)
        
        setUpAttribute(source)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = historyView
    }
    
    private func setUpAttribute(_ source: UIBarButtonItem) {
        modalPresentationStyle = .popover
        preferredContentSize = CGSize(width: 600, height: historyView.tableView.frame.height)
        popoverPresentationController?.permittedArrowDirections = .up
        popoverPresentationController?.sourceRect = source.accessibilityFrame
    }
}
