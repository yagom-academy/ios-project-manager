//
//  CircleLabel.swift
//  ProjectManager
//
//  Created by 리지 on 2023/05/18.
//

import UIKit

final class CircleLabel: UILabel {
    
    private let padding = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
  
    init() {
        super.init(frame: .zero)
        self.textColor = .white
        self.backgroundColor = .black
        self.font = UIFont.preferredFont(forTextStyle: .headline)
        self.textAlignment = .center
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.masksToBounds = true
        layer.cornerRadius = rect.height * 0.5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeText(count: String) {
        self.text = count
    }
}
