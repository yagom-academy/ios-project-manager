//
//  TitleTextField.swift
//  ProjectManager
//
//  Created by junho lee on 2023/01/14.
//

import UIKit

class TitleTextField: UITextField {
    let inset = Constants.defaultSpacing

    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.placeholder = NSLocalizedString("Title", comment: "TitleTextField placeholder")
        self.font = UIFont.preferredFont(forTextStyle: .title3)
        self.adjustsFontForContentSizeCategory = true
        self.backgroundColor = ProjectColor.defaultBackground.color
        self.layer.borderWidth = Constants.borderWidth
        self.addShadow()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: inset, dy: inset)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: inset, dy: inset)
    }
}
