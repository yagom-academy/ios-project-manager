//
//  KanBanTableView.swift
//  ProjectManager
//
//  Created by 천수현 on 2021/07/20.
//

import UIKit

class KanBanTableView: UITableView {
    var statusName: String = ""
    var tasks: [String] = []

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
