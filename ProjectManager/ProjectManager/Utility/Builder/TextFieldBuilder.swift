//
//  TextFieldBuilder.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/23.
//

import UIKit

protocol TextFieldBuilder: UseAutoLayout, UseLayer {
    associatedtype Builder
    
    var textField: UITextField { get }
    
    func setFont(_ font: UIFont) -> Builder
    func setPlaceholder(_ str: String) -> Builder
    func setBackgroundColor(_ color: UIColor) -> Builder
    func addLeftPadding() -> Builder
    func setHeightAnchor(_ const: CGFloat) -> Builder
}

final class DefaultTextFieldBuilder: TextFieldBuilder {
    typealias Builder = DefaultTextFieldBuilder
    
    var textField: UITextField = UITextField()
    
    func setFont(_ font: UIFont) -> DefaultTextFieldBuilder {
        textField.font = font
        return self
    }
    
    func setPlaceholder(_ str: String) -> DefaultTextFieldBuilder {
        textField.placeholder = str
        return self
    }
    
    func setBackgroundColor(_ color: UIColor) -> DefaultTextFieldBuilder {
        textField.backgroundColor = color
        return self
    }
    
    func addLeftPadding() -> DefaultTextFieldBuilder {
        textField.addLeftPadding()
        return self
    }
    
    func setHeightAnchor(_ const: CGFloat) -> DefaultTextFieldBuilder {
        textField.heightAnchor.constraint(equalToConstant: const).isActive = true
        return self
    }
    
    func useAutoLayout() -> DefaultTextFieldBuilder {
        textField.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    func setLayerMaskToBounds(_ bool: Bool) -> DefaultTextFieldBuilder {
        textField.layer.masksToBounds = true
        return self
    }
    
    func setLayerBorderWidth(_ width: CGFloat) -> DefaultTextFieldBuilder {
        textField.layer.borderWidth = width
        return self
    }
    
    func setLayerBorderColor(_ color: UIColor) -> DefaultTextFieldBuilder {
        textField.layer.borderColor = color.cgColor
        return self
    }
    
    func setLayerShadowOffset(width: CGFloat, height: CGFloat) -> DefaultTextFieldBuilder {
        textField.layer.shadowOffset = CGSize(width: width, height: height)
        return self
    }
    
    func setLayerShadowOpacity(_ opacity: Float) -> DefaultTextFieldBuilder {
        textField.layer.shadowOpacity = opacity
        return self
    }
    
    func setLayerCornerRadius(_ number: CGFloat) -> DefaultTextFieldBuilder {
        textField.layer.cornerRadius = number
        return self
    }
    
    func setLayerBackgroundColor(_ color: UIColor) -> DefaultTextFieldBuilder {
        textField.layer.backgroundColor = color.cgColor
        return self
    }
}
