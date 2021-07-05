//
//  NewTodoFormTextView.swift
//  ProjectManager
//
//  Created by 김민성 on 2021/07/05.
//

import UIKit

class NewTodoFormTextView: UITextView {
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 4
        layer.borderColor = UIColor.systemGray4.cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.3
        
        backgroundColor = .systemBackground
        
    }
}
