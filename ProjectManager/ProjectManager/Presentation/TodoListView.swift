//
//  TodoListView.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/05.
//

import UIKit
import SnapKit

final class HeaderView: UIView {
    private let title: String
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, countLabel])
        stackView.spacing = 8
        
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.text = title
        
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .label
        label.textColor = .systemBackground
        label.clipsToBounds = true
        label.layer.cornerRadius = 15
        label.textAlignment = .center
        
        return label
    }()
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        configureLayout()
        self.backgroundColor = .systemGray6
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        self.addSubview(labelStackView)
        labelStackView.snp.makeConstraints { make in
            make.top.leading.bottom.equalTo(self).inset(8)
        }
        
        countLabel.snp.makeConstraints { make in
            make.width.equalTo(countLabel.snp.height)
            make.height.equalTo(30)
        }
    }
}

extension HeaderView {
    func setCountText(to count: String) {
        countLabel.text = count
    }
}

final class TodoListView: UIView {
    private lazy var tableStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [todoStackView, doingStackView, doneStackView])
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .systemGray3
        stackView.spacing = 8
        
        return stackView
    }()
    
    private lazy var todoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [todoHeaderView, todoTableView])
        stackView.axis = .vertical
        stackView.spacing = 1
        
        return stackView
    }()
    
    let todoHeaderView = HeaderView(title: "TODO")
   
    let todoTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray6
        
        return tableView
    }()
    
    private lazy var doingStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [doingHeaderView, doingTableView])
        stackView.axis = .vertical
        stackView.spacing = 1
        
        return stackView
    }()
    
    let doingHeaderView = HeaderView(title: "DOING")
    
    let doingTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray6
        
        return tableView
    }()
    
    private lazy var doneStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [doneHeaderView, doneTableView])
        stackView.axis = .vertical
        stackView.spacing = 1
        
        return stackView
    }()
    
    let doneHeaderView = HeaderView(title: "DONE")
    
    let doneTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray6
        
        return tableView
    }()
    
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
