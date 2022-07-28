//
//  HistoryTableViewCell.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/28.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    private func setViewLayout() {
        self.backgroundColor = .systemBlue
    }
}
