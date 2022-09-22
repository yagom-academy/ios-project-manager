//
//  StackViewBuilder.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/21.
//

import UIKit

protocol StackViewBuilder {
    var stackView: UIStackView { get }
    
    func useAutoLayout() -> StackViewBuilder
    func useLayoutMargin() -> StackViewBuilder
    func setAxis(_ axis: NSLayoutConstraint.Axis) -> StackViewBuilder
    func setDistribution(_ distribution: UIStackView.Distribution) -> StackViewBuilder
    func setAlignment(_ alignment: UIStackView.Alignment) -> StackViewBuilder
    func setSpacing(_ space: CGFloat) -> StackViewBuilder
    func setBackgroundColor(_ color: UIColor) -> StackViewBuilder
    func setLayoutMargin(top: CGFloat,
                         left: CGFloat,
                         bottom: CGFloat,
                         right: CGFloat) -> StackViewBuilder
}

final class DefaultStackViewBuilder: StackViewBuilder {    
    var stackView: UIStackView = UIStackView()
    
    func useAutoLayout() -> StackViewBuilder {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    func useLayoutMargin() -> StackViewBuilder {
        stackView.isLayoutMarginsRelativeArrangement = true
        return self
    }
    
    func setLayoutMargin(top: CGFloat, left: CGFloat,
                         bottom: CGFloat, right: CGFloat) -> StackViewBuilder {
        stackView.layoutMargins = UIEdgeInsets(top: top, left: left,
                                               bottom: bottom, right: right)
        return self
    }
    
    func setAxis(_ axis: NSLayoutConstraint.Axis) -> StackViewBuilder {
        stackView.axis = axis
        return self
    }
    
    func setDistribution(_ distribution: UIStackView.Distribution) -> StackViewBuilder {
        stackView.distribution = distribution
        return self
    }
    
    func setAlignment(_ alignment: UIStackView.Alignment) -> StackViewBuilder {
        stackView.alignment = alignment
        return self
    }
    
    func setSpacing(_ space: CGFloat) -> StackViewBuilder {
        stackView.spacing = space
        return self
    }
    
    func setBackgroundColor(_ color: UIColor) -> StackViewBuilder {
        stackView.backgroundColor = color
        return self
    }
}
