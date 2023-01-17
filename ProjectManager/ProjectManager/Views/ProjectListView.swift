//
//  ProjectListView.swift
//  ProjectManager
//
//  Created by 노유빈 on 2023/01/17.
//

import UIKit

final class ProjectListView: UIView {
    // MARK: Properties
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: bounds)
        stackView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()

    let todoTableView = ProjectTableView(headerTitle: "TODO")
    let doingTableView = ProjectTableView(headerTitle: "DOING")
    let doneTableView = ProjectTableView(headerTitle: "DONE")

    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private Method
    private func configureView() {
        backgroundColor = .lightGray
        addSubview(stackView)

        stackView.addArrangedSubview(todoTableView)
        stackView.addArrangedSubview(doingTableView)
        stackView.addArrangedSubview(doneTableView)
    }
}
