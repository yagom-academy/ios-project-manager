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
        backgroundColor = .systemGray6
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 150
        register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
        register(ListHeaderView.self, forHeaderFooterViewReuseIdentifier: ListHeaderView.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
