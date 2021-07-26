//
//  TitleLabel.swift
//  ProjectManager
//
//  Created by 오인탁 on 2021/07/26.
//

import UIKit

class TitleLabel: UILabel {
    init(title: String) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.text = title
        self.font = UIFont.preferredFont(forTextStyle: .largeTitle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
