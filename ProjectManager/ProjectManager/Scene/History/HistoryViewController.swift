//
//  HistoryViewController.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/27.
//

import UIKit

final class HistoryViewController: UIViewController {
    let viewModel: HistoryViewModelable
    
    init(viewModel: HistoryViewModelable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let historyView = HistoryView()
    
    override func loadView() {
        super.loadView()
        self.view = historyView
    }
    
}
