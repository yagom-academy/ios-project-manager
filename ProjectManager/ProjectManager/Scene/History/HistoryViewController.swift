//
//  HistoryViewController.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/27.
//

import UIKit

final class HistoryViewController: UIViewController {
    
    
    let historyView = HistoryView()
    
    override func loadView() {
        super.loadView()
        self.view = historyView
    }
    
}
