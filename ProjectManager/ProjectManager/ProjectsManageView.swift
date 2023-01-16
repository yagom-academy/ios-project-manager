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
        self.backgroundColor = .white
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
            stackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
