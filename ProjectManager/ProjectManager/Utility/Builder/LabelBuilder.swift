//
//  Builder.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/21.
//

import UIKit

protocol LabelBuilder {
    var label: UILabel { get }
    
    func useAutoLayout() -> LabelBuilder
    func setPreferredFont(_ font: UIFont.TextStyle) -> LabelBuilder
    func setText(with text: String) -> LabelBuilder
    func setTextColor(with textColor: UIColor) -> LabelBuilder
    func setTextAlignment(_ alignment: NSTextAlignment) -> LabelBuilder
    func numberOfLines(_ number: Int) -> LabelBuilder
    func useLayerMaskToBound() -> LabelBuilder
    func layerCornerRadius(_ number: CGFloat) -> LabelBuilder
    func layerBackground(color: CGColor) -> LabelBuilder
}

final class DefaultLabelBuilder: LabelBuilder {
    var label: UILabel = UILabel()
    
    func useAutoLayout() -> LabelBuilder {
        label.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    func setPreferredFont(_ font: UIFont.TextStyle) -> LabelBuilder {
        label.font = UIFont.preferredFont(forTextStyle: font)
        return self
    }
    
    func setText(with text: String) -> LabelBuilder {
        label.text = text
        return self
    }
    
    func setTextColor(with textColor: UIColor) -> LabelBuilder {
        label.textColor = textColor
        return self
    }
    
    func setTextAlignment(_ alignment: NSTextAlignment) -> LabelBuilder {
        label.textAlignment = alignment
        return self
    }
    
    func numberOfLines(_ number: Int) -> LabelBuilder {
        label.numberOfLines = number
        return self
    }
    
    func useLayerMaskToBound() -> LabelBuilder {
        label.layer.masksToBounds = true
        return self
    }
    
    func layerCornerRadius(_ number: CGFloat) -> LabelBuilder {
        label.layer.cornerRadius = number
        return self
    }
    
    func layerBackground(color: CGColor) -> LabelBuilder {
        label.layer.backgroundColor = color
        return self
    }
    
}
