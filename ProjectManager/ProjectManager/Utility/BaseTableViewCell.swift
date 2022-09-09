//
//  BaseTableViewCell.swift
//  ProjectManager
//
//  Created by Derrick kim on 9/9/22.
//

import UIKit

class BaseTableViewCell<T>: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure() {
        selectionStyle = .none
    }
    
    var model: T? {
        didSet {
            if let model = model {
                bind(model)
            }
        }
    }
    
    func bind(_ model: T) {}
}
