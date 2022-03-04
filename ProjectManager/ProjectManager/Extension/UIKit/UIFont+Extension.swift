//
//  UIFont+Extension.swift
//  ProjectManager
//
//  Created by 고은 on 2022/03/04.
//

import UIKit

extension UIFont {

    static func preferredFont(for style: TextStyle, weight: Weight) -> UIFont {
        let metrics = UIFontMetrics(forTextStyle: style)
        let desc = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style)
        let font = UIFont.systemFont(ofSize: desc.pointSize, weight: weight)

        return metrics.scaledFont(for: font)
    }
}
