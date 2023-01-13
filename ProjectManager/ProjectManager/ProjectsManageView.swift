//
//  ProjectsManageView.swift
//  ProjectManager
//
//  Created by jin on 1/12/23.
//

import UIKit

class ProjectsManageView: UIView {

    // MARK: - Properties

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let todoView: SingleProjectManageView = {
        let view = SingleProjectManageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let doingView: SingleProjectManageView = {
        let view = SingleProjectManageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let doneView: SingleProjectManageView = {
        let view = SingleProjectManageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - LifeCycles

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI settings

    private func configureUI() {
        self.backgroundColor = .orange
        addSubview(stackView)
        stackView.addArrangedSubview(todoView)
        stackView.addArrangedSubview(doingView)
        stackView.addArrangedSubview(doneView)
        configureConstraints()
        todoView.setHeaderText(text: "TODO")
        doingView.setHeaderText(text: "DOING")
        doneView.setHeaderText(text: "DONE")
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
//            todoView.widthAnchor.constraint(equalTo: doingView.widthAnchor),
//            doingView.widthAnchor.constraint(equalTo: doneView.widthAnchor),
//            doneView.widthAnchor.constraint(equalTo: todoView.widthAnchor)
        ])
    }
}
