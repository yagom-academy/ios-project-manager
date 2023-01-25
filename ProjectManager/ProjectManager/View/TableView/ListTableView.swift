//
//  ListTableView.swift
//  ProjectManager
//
//  Created by 애쉬 on 2023/01/14.
//

import UIKit

final class ListTableView: UITableView {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        backgroundColor = .systemGray6
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 150
        register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewValue.identifier)
        register(ListHeaderView.self, forHeaderFooterViewReuseIdentifier: HeaderViewValue.identifier)
    }
}
