//
//  ProjectManagerTableViewCell.swift
//  ProjectManager
//
//  Created by idinaloq on 2023/09/21.
//

import UIKit

final class ProjectManagerTableViewCell: UITableViewCell {
    private let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 1
        
        return label
    }()
    
    private let bodyLabel: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 3
        
        return label
    }()
    
    private let deadlineLabel: UILabel = {
        let label: UILabel = UILabel()
        
        return label
    }()
}
