//
//  ListTableViewCell.swift
//  ProjectManager
//
//  Created by Toy on 1/25/24.
//

import UIKit

final class ListTableViewCell: UITableViewCell {
    // MARK: - Property
    static let identifier = String(describing: ListViewController.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    // MARK: - Helper
    
}
