//
//  UITableView+Extension.swift
//  ProjectManager
//
//  Created by 우롱차, 파프리 on 2022/07/12.
//

import UIKit

extension UITableView {
    var numberOfoneSectionRows: Int {
        guard self.numberOfSections > 0 else {
            return 0
        }
        return self.numberOfRows(inSection: 0)
    }
}
