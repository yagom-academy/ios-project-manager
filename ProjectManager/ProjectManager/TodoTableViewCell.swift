//
//  TodoTableViewCell.swift
//  ProjectManager
//
//  Created by bonf on 2022/09/07.
//

import UIKit

final class TodoTableViewCell: UITableViewCell {
    static let identifier = "CustumCell"
    
    // MARK: - properties

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(forTextStyle: .title3)
        
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(forTextStyle: .body)
        
        return label
    }()
    
}
