//
//  ItemContentLabel.swift
//  ProjectManager
//
//  Created by 이영우 on 2021/07/22.
//

import UIKit

class ItemContentLabel: UILabel {
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.numberOfLines = 3
        self.lineBreakMode = .byTruncatingTail
        self.font = UIFont.preferredFont(forTextStyle: .body)
        self.textColor = .systemGray4
    }
}
