//
//  TitleTextField.swift
//  ProjectManager
//
//  Created by junho lee on 2023/01/14.
//

import UIKit

class TitleTextField: UITextField {
    private let inset = Constants.defaultSpacing

    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        placeholder = NSLocalizedString("Title", comment: "TitleTextField placeholder")
        font = UIFont.preferredFont(forTextStyle: .title3)
        adjustsFontForContentSizeCategory = true
        backgroundColor = ProjectColor.defaultBackground.color
        layer.borderWidth = Constants.borderWidth
        addShadow()
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
