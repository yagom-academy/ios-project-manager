//
//  HistoryPopOverView.swift
//  ProjectManager
//
//  Created by 우롱차, 파프리 on 25/07/2022.
//

import UIKit

final class HistoryPopOverView: UIView {
    private enum Constant {
        static let buttonTitleColor: UIColor = .systemBlue
        static let buttonBackgroundColor: UIColor = .white
        static let viewBackgroundColor: UIColor = .systemGray6
    }
    
    private(set) var baseTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Functions
extension HistoryPopOverView {
    func setDelegate(delegate: UITableViewDelegate & UITableViewDataSource) {
        self.baseTableView.delegate = delegate
        self.baseTableView.dataSource = delegate
    }
}
    
// MARK: setUp
extension HistoryPopOverView {
    private func setUp() {
        backgroundColor = Constant.viewBackgroundColor
        addSubview(baseTableView)
        setConstraint()
    }
    
    private func setConstraint() {
        NSLayoutConstraint.activate([
            baseTableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            baseTableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            baseTableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 15),
            baseTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -15)
        ])
    }
}
