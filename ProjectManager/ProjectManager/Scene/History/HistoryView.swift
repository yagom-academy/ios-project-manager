//
//  HistoryView.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/27.
//

import SnapKit

final class HistoryView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private(set) lazy var historyTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        tableView.register(HistoryTableViewCell.self)
        return tableView
    }()
    
    private func setLayout() {
        self.addSubview(historyTableView)
        historyTableView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
    }
}
