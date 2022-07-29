//
//  UITableViewCell+Sugar.swift
//  ProjectManager
//
//  Created by 김동욱 on 2022/07/22.
//

import UIKit

extension UITableViewCell {
    static var identifier: String {
        String(describing: Self.self)
    }
}
