//
//  WorkTableView.swift
//  ProjectManager
//
//  Created by Judy on 2022/09/14.
//

import UIKit

final class WorkTableView: UITableView {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    init(state: WorkState, frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.tag = state.rawValue
        setupView()
    }
    
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.register(WorkTableViewCell.self, forCellReuseIdentifier: WorkTableViewCell.identifier)
        self.backgroundColor = .systemBackground
        self.sectionHeaderHeight = 50
        if #available(iOS 15.0, *) {
            self.sectionHeaderTopPadding = .leastNormalMagnitude
        }
    }
}
