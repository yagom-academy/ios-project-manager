//
//  Subclass.swift
//  ProjectManager
//
//  Created by 리나 on 2021/03/15.
//

import UIKit

// MARK: - Label - UILabel

class Label: UILabel {
    init(textColor: UIColor = .black, textSize: UIFont.TextStyle = .body, numberOfLines: Int = 1) {
        super.init(frame: .zero)
        self.textColor = textColor
        self.font = .preferredFont(forTextStyle: textSize)
        self.numberOfLines = numberOfLines
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
