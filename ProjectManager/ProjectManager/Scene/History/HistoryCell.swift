//
//  HistoryCell.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/22.
//

import UIKit
import SnapKit

final class HistoryCell: UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    private let baseStackView = UIStackView().then {
        $0.distribution = .fillEqually
        $0.axis = .vertical
        $0.spacing = 5
    }
    
    private let actionLabel = UILabel().then {
        $0.font = .preferredFont(forTextStyle: .title3)
        $0.numberOfLines = 2
    }
    
    private let timeLabel = UILabel().then {
        $0.font = .preferredFont(forTextStyle: .body)
        $0.textColor = .systemGray2
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubViews()
        setupUILayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubViews() {
        contentView.addSubview(baseStackView)
        baseStackView.addArrangedSubview(actionLabel)
        baseStackView.addArrangedSubview(timeLabel)
    }
    
    private func setupUILayout() {
        baseStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
    }
    
    func setupContents(history: History) {
        actionLabel.text = history.content
        timeLabel.text = history.timeDescription()
    }
}
