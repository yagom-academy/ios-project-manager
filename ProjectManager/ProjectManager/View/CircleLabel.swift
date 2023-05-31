//
//  CircleLabel.swift
//  ProjectManager
//
//  Created by 리지 on 2023/05/18.
//

import UIKit

final class CircleLabel: UILabel {
    init() {
        super.init(frame: .zero)
        self.textColor = .white
        self.backgroundColor = .black
        self.font = UIFont.preferredFont(forTextStyle: .title2)
        self.textAlignment = .center
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.masksToBounds = true
        layer.cornerRadius = bounds.height / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeText(count: String) {
        self.text = count
    }
}
