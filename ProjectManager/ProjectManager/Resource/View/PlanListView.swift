//
//  PlanListView.swift
//  ProjectManager
//
//  Created by 정선아 on 2023/01/16.
//

import UIKit

class PlanListView: UIView {
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: bounds)
        stackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 4
        return stackView
    }()

    let toDoTableView = PlanTableView()
    let doingTableView = PlanTableView()
    let doneTableView = PlanTableView()

    init() {
        super.init(frame: .zero)
        configureLayout()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureLayout() {
        addSubview(stackView)

        stackView.addArrangedSubview(toDoTableView)
        stackView.addArrangedSubview(doingTableView)
        stackView.addArrangedSubview(doneTableView)
    }
    
}
