//
//  MainView.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/04.
//

import UIKit

final class MainView: UIView {
    let toDoTable = ProjectListView(title: ProjectStatus.todo.string)
    let doingTable = ProjectListView(title: ProjectStatus.doing.string)
    let doneTable = ProjectListView(title: ProjectStatus.done.string)
    
    private let baseStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        stackView.backgroundColor = .systemGray4
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setUpBackgroundColor()
        setUpTableViews()
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpBackgroundColor() {
        backgroundColor = .systemBackground
    }
    
    private func setUpTableViews() {
        addSubview(baseStackView)
        
        baseStackView.addArrangedSubview(toDoTable)
        baseStackView.addArrangedSubview(doingTable)
        baseStackView.addArrangedSubview(doneTable)
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([
            baseStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            baseStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            baseStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            baseStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
