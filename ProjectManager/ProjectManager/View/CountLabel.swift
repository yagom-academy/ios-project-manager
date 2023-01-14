//
//  CountLabel.swift
//  ProjectManager
//
//  Created by summercat on 2023/01/13.
//

import UIKit

final class CountLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, textCount: String) {
        self.init(frame: frame)
        self.text = textCount
        
        font = .preferredFont(forTextStyle: .headline)
        backgroundColor = .systemFill
        textAlignment = .center
        translatesAutoresizingMaskIntoConstraints = false
        layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        layer.cornerRadius = bounds.size.height * 0.5
        
        guard let text = self.text, let count = Int(text) else { return }
        if count > 99 { self.text = "99+" }
    }
}
