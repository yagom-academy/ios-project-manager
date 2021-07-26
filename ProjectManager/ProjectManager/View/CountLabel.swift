//
//  CountLabel.swift
//  ProjectManager
//
//  Created by 오인탁 on 2021/07/26.
//

import UIKit

class CountLabel: UILabel {
    let type: String
    
    init(type: String) {
        self.type = type
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .black
        self.textColor = .white
        self.text = "0"
        self.font = UIFont.preferredFont(forTextStyle: .title2)
        self.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
