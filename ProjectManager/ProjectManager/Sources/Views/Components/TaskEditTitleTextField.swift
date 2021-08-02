//
//  TaskEditTitleTextField.swift
//  ProjectManager
//
//  Created by duckbok, Ryan-Son on 2021/07/23.
//

import UIKit

final class TaskEditTitleTextField: UITextField {

    private enum Style {
        static let backgroundColor: UIColor = .systemBackground

        static let shadowColor: UIColor = .systemGray3
        static let shadowOffset: CGSize = CGSize(width: 0, height: 3)
        static let shadowOpacity: Float = 1
        static let shadowRadius: CGFloat = 4

        static let textPadding = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        static let textPlaceholder: String = "Title"
        static let textStyle: UIFont.TextStyle = .title1
    }

    // MARK: Initializers

    init() {
        super.init(frame: .zero)
        setAttributes()
        setShadowStyle()
        setPriorities()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: Configure

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: Style.textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: Style.textPadding)
    }

    private func setAttributes() {
        backgroundColor = Style.backgroundColor
        font = UIFont.preferredFont(forTextStyle: Style.textStyle)
        placeholder = Style.textPlaceholder
    }

    private func setShadowStyle() {
        layer.shadowColor = Style.shadowColor.cgColor
        layer.shadowOffset = Style.shadowOffset
        layer.shadowOpacity = Style.shadowOpacity
        layer.shadowRadius = Style.shadowRadius
    }

    private func setPriorities() {
        setContentHuggingPriority(.required, for: .vertical)
        setContentCompressionResistancePriority(.required, for: .vertical)
    }
}
