//
//  MainView.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/04.
//

import UIKit

final class MainView: UIView {
    let toDoTableView = ProjectTableView(title: "TODO")
    let doingTableView = ProjectTableView(title: "DOING")
    let doneTableView = ProjectTableView(title: "DONE")
    
    private let baseStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
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
        
        baseStackView.addArrangedSubview(toDoTableView)
        baseStackView.addArrangedSubview(doingTableView)
        baseStackView.addArrangedSubview(doneTableView)
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([
            baseStackView.topAnchor.constraint(equalTo: topAnchor),
            baseStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            baseStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            baseStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
