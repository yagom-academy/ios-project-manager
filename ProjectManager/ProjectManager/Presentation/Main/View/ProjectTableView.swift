//
//  ProjectTableView.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/04.
//

import UIKit

final class ProjectTableView: UITableView {
    init() {
        super.init(frame: .zero, style: .grouped)
        
        setUpAttribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpAttribute() {
        
    }
}
