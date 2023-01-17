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
        self.backgroundColor = .systemGray6
        self.rowHeight = 100
        self.estimatedRowHeight = 150
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
