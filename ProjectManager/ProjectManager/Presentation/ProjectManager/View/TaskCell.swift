//
//  TaskCell.swift
//  ProjectManager
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import UIKit

final class TaskCell: UITableViewCell {
    
    var taskTitleLabel: UILabel = {
       let label = UILabel()
        return label
    }()
    var taskDescriptionLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    var taskExpirationLabel: UILabel = {
        let label = UILabel()
        return label
    }()
}
