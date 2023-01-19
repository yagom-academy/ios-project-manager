//
//  DetailTextView.swift
//  ProjectManager
//
//  Created by GUNDY on 2023/01/19.
//

import UIKit

final class DetailTextView: UITextView {

    typealias Style = Constant.Style

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        configureShadow()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureShadow() {
        layer.masksToBounds = false
        layer.shadowOpacity = Style.shadowOpacity
        layer.shadowOffset = Style.shadowOffset
    }
}
