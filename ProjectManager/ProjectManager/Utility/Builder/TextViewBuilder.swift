//
//  TextViewBuilder.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/23.
//

import UIKit

protocol TextViewBuilder: UseAutoLayout, UseLayer {
    associatedtype Builder
    
    var textView: UITextView { get }
    
    func isScrollEnable(_ bool: Bool) -> Builder
    func setFont(_ font: UIFont) -> Builder
    func setBackgroundColor(_ color: UIColor) -> Builder
}

final class DefaultTextViewBuilder: TextViewBuilder {
    typealias Builder = DefaultTextViewBuilder
    
    var textView: UITextView = UITextView()
    
    func useAutoLayout() -> Builder {
        textView.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    func isScrollEnable(_ bool: Bool) -> Builder {
        textView.isScrollEnabled = bool
        return self
    }
    
    func setFont(_ font: UIFont) -> Builder {
        textView.font = font
        return self
    }
    
    func setBackgroundColor(_ color: UIColor) -> Builder {
        textView.backgroundColor = color
        return self
    }
    
    func setLayerMaskToBounds(_ bool: Bool) -> Builder {
        textView.layer.masksToBounds = bool
        return self
    }
    
    func setLayerBorderWidth(_ width: CGFloat) -> Builder {
        textView.layer.borderWidth = width
        return self
    }
    
    func setLayerBorderColor(_ color: UIColor) -> Builder {
        textView.layer.borderColor = color.cgColor
        return self
    }
    
    func setLayerShadowOffset(width: CGFloat, height: CGFloat) -> Builder {
        textView.layer.shadowOffset = CGSize(width: width, height: height)
        return self
    }
    
    func setLayerShadowOpacity(_ opacity: Float) -> Builder {
        textView.layer.shadowOpacity = opacity
        return self
    }
    
    func setLayerCornerRadius(_ number: CGFloat) -> DefaultTextViewBuilder {
        textView.layer.cornerRadius = number
        return self
    }
    
    func setLayerBackgroundColor(_ color: UIColor) -> DefaultTextViewBuilder {
        textView.layer.backgroundColor = color.cgColor
        return self
    }
}
