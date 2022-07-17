//
//  TodoListView.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/05.
//

import UIKit
import SnapKit

final class TodoListView: UIView {
    private lazy var tableStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [todo, doing, done])
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .systemGray3
        stackView.spacing = 8
        
        return stackView
    }()

    let todo = TodoListTableView(title: "TODO")
    
    let doing = TodoListTableView(title: "DOING")
    
    let done = TodoListTableView(title: "DONE")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
        self.backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        self.addSubview(tableStackView)
        tableStackView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
