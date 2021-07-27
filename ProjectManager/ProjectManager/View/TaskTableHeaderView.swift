//
//  TaskTableHeaderView.swift
//  ProjectManager
//
//  Created by 천수현 on 2021/07/21.
//

import UIKit

class TaskTableHeaderView: UIView {
    let statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        return label
    }()

    let countLabel: UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.textAlignment = .center
        label.layer.borderWidth = 2
        label.layer.cornerRadius = 5
        label.layer.borderColor = UIColor.black.cgColor
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()

    init() {
        super.init(frame: .zero)
        backgroundColor = .systemGray

        addSubview(statusLabel)
        statusLabel.snp.makeConstraints { label in
            label.top.equalTo(self).inset(10)
            label.leading.equalTo(self).inset(10)
            label.centerY.equalTo(self)
            label.bottom.equalTo(self).inset(10)
        }

        addSubview(countLabel)
        countLabel.snp.makeConstraints { label in
            label.leading.equalTo(statusLabel.snp.trailing).offset(10)
            label.centerY.equalTo(self)
            label.width.equalTo(25)
            label.height.equalTo(25)
        }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setText(status: String, count: String) {
        statusLabel.text = status
        countLabel.text = count
    }
}
