//
//  ProjectTableView.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/04.
//

import UIKit

final class ProjectTableView: UITableView {
    init() {
    private let headerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let listTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.sizeToFit()
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.layer.masksToBounds = true
        label.layer.cornerRadius = label.bounds.height / 2
        label.backgroundColor = .black
        label.textColor = .white
        return label
    }()
        super.init(frame: .zero, style: .grouped)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        
    }
}
