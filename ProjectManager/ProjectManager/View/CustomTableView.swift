//
//  CustomTableView.swift
//  ProjectManager
//
//  Created by Baem on 2023/01/13.
//

import UIKit

final class CustomTableView: UITableView {
    var title: String
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero, style: .plain)
        
        self.register(TodoCustomCell.self, forCellReuseIdentifier: "TodoCustomCell")
        self.register(CustomHeaderView.self, forHeaderFooterViewReuseIdentifier: "CustomHeaderView")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
