//
//  TextAttribute.swift
//  ProjectManager
//
//  Created by 이차민 on 2022/03/14.
//

import UIKit

enum TextAttribute {
    static let overDeadline = [
        NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .subheadline),
        NSAttributedString.Key.foregroundColor: UIColor.red
    ]
    
    static let underDeadline = [
        NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .subheadline),
        NSAttributedString.Key.foregroundColor: UIColor.label
    ]
}
