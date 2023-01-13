//
//  ProcessStackView.swift
//  ProjectManager
//
//  Created by Kyo on 2023/01/11.
//

import UIKit

final class ProcessStackView: UIStackView {
    private enum UIConstraint {
        static let headerViewHeight = 70.0
        static let headerSectionHeight = 7.0
        static let stackViewSpacing = 1.0
    }
    
    let headerView: HeaderView
    let tableView = UITableView(frame: .zero, style: .grouped)
        
    init(process: Process) {
        headerView = HeaderView(process: process)
        super.init(frame: .zero)
        setupView()
        setupTableView()
        setupCosntraint()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI Configuration
extension ProcessStackView {
    private func setupView() {
        [headerView, tableView].forEach(addArrangedSubview(_:))
        axis = .vertical
        alignment = .fill
        distribution = .fill
        spacing = UIConstraint.stackViewSpacing
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .systemGray5
        tableView.tableHeaderView = UIView(frame: CGRect(
            x: .zero,
            y: .zero,
            width: .zero,
            height: UIConstraint.headerSectionHeight)
        )
        tableView.sectionHeaderHeight = UIConstraint.headerSectionHeight
        tableView.sectionFooterHeight = .zero
        tableView.register(
            ProcessTableViewCell.self,
            forCellReuseIdentifier: ProcessTableViewCell.identifier
        )
    }
    
    private func setupCosntraint() {
        let safeArea = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            headerView.widthAnchor.constraint(equalTo: widthAnchor),
            headerView.heightAnchor.constraint(equalToConstant: UIConstraint.headerViewHeight)
        ])
    }
}
