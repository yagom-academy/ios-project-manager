//
//  StackViewBuilder.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/21.
//

import UIKit

protocol StackViewBuilder: UseAutoLayout {
    associatedtype Builder
    
    var stackView: UIStackView { get }
    
    func useLayoutMargin() -> Builder
    func setAxis(_ axis: NSLayoutConstraint.Axis) -> Builder
    func setDistribution(_ distribution: UIStackView.Distribution) -> Builder
    func setAlignment(_ alignment: UIStackView.Alignment) -> Builder
    func setSpacing(_ space: CGFloat) -> Builder
    func setBackgroundColor(_ color: UIColor) -> Builder
    func setLayoutMargin(top: CGFloat,
                         left: CGFloat,
                         bottom: CGFloat,
                         right: CGFloat) -> Builder
}

final class DefaultStackViewBuilder: StackViewBuilder {
    typealias Builder = DefaultStackViewBuilder
    
    var stackView: UIStackView = UIStackView()
    
    func useAutoLayout() -> Builder {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    func useLayoutMargin() -> Builder {
        stackView.isLayoutMarginsRelativeArrangement = true
        return self
    }
    
    func setLayoutMargin(top: CGFloat, left: CGFloat,
                         bottom: CGFloat, right: CGFloat) -> Builder {
        stackView.layoutMargins = UIEdgeInsets(top: top, left: left,
                                               bottom: bottom, right: right)
        return self
    }
    
    func setAxis(_ axis: NSLayoutConstraint.Axis) -> Builder {
        stackView.axis = axis
        return self
    }
    
    func setDistribution(_ distribution: UIStackView.Distribution) -> Builder {
        stackView.distribution = distribution
        return self
    }
    
    func setAlignment(_ alignment: UIStackView.Alignment) -> Builder {
        stackView.alignment = alignment
        return self
    }
    
    func setSpacing(_ space: CGFloat) -> Builder {
        stackView.spacing = space
        return self
    }
    
    func setBackgroundColor(_ color: UIColor) -> Builder {
        stackView.backgroundColor = color
        return self
    }
}
