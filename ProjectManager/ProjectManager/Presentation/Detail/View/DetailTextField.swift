//
//  DetailTextField.swift
//  ProjectManager
//
//  Created by 이준영 on 2023/01/19.
//

import UIKit

class DetailTextField: UITextField {
    
    typealias Style = Constant.Style

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureShadow()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: Style.listTitleMargin,
                                             left: Style.listTitleMargin,
                                             bottom: Style.listTitleMargin,
                                             right: Style.listTitleMargin))
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: Style.listTitleMargin,
                                             left: Style.listTitleMargin,
                                             bottom: Style.listTitleMargin,
                                             right: Style.listTitleMargin))
    }
    
    private func configureShadow() {
        backgroundColor = .systemBackground
        layer.shadowOpacity = Style.shadowOpacity
        layer.shadowOffset = Style.shadowOffset
    }
}
