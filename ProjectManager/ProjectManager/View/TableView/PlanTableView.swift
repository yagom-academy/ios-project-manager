//
//  PlanTableView.swift
//  ProjectManager
//
//  Created by 리지 on 2023/05/25.
//

import UIKit

final class PlanTableView: UITableView {
    
    private var header: HeaderView
    
    init(headerName: String) {
        self.header = HeaderView(text: headerName, frame: CGRect.zero)
        super.init(frame: CGRect.zero, style: .plain)
        setUpPlanTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpPlanTableView() {
        self.backgroundColor = .systemGroupedBackground
        self.register(PlanTableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableHeaderView = header
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        header.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 60)
    }
    
    func updateItemCount(_ count: String) {
        header.changeCount(count)
    }
}
