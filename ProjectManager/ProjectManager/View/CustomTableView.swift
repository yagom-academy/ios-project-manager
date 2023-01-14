//
//  CustomTableView.swift
//  ProjectManager
//
//  Created by Baem on 2023/01/13.
//

import UIKit

final class CustomTableView: UITableView {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.register(TodoCustomCell.self, forCellReuseIdentifier: "TodoCustomCell")
        self.register(CustomHeaderView.self, forHeaderFooterViewReuseIdentifier: "CustomHeaderView")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
