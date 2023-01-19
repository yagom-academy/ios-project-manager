//
//  ListView.swift
//  ProjectManager
//
//  Created by GUNDY on 2023/01/15.
//

import UIKit

final class ListView: UITableView {

    typealias Color = Constant.Color

    private(set) var state: State

    init(state: State, frame: CGRect, style: UITableView.Style) {
        self.state = state
        super.init(frame: frame, style: style)
        
        configureUIComponent()
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUIComponent() {
        backgroundColor = Color.listBackground
    }
}
