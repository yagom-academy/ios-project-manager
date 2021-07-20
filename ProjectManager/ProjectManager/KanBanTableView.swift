//
//  KanBanTableView.swift
//  ProjectManager
//
//  Created by 천수현 on 2021/07/20.
//

import UIKit

final class KanBanTableView: UITableView {
    private(set) var statusName: String = ""

    init(statusName: String) {
        self.statusName = statusName

        super.init(frame: .zero, style: .grouped)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
