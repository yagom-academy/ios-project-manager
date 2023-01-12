//
//  ProcessTableView.swift
//  ProjectManager
//
//  Created by Kyo on 2023/01/11.
//

import UIKit

final class ProcessTableView: UITableView {
    private enum UIConstraint {
        static let headerViewHeight = 100.0
    }
    
    let headerView: HeaderView
    
    init(process: Process) {
        headerView = HeaderView(process: process)
        super.init(frame: .zero, style: .grouped)
        setupView()
        setupCosntraint()
        layoutIfNeeded()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI Configuration
extension ProcessTableView {
    private func setupView() {
        tableHeaderView = headerView
        headerView.translatesAutoresizingMaskIntoConstraints = false
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(headerView)
    }
    
    private func setupCosntraint() {
        NSLayoutConstraint.activate([
            headerView.widthAnchor.constraint(equalTo: widthAnchor),
            headerView.heightAnchor.constraint(equalToConstant: UIConstraint.headerViewHeight)
        ])
    }
}
