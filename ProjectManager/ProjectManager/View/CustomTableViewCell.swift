//
//  CustomTableViewCell.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/06.
//

import UIKit
import SnapKit

final class CustomTableViewCell: UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    private lazy var baseCellStackView = UIStackView(
        arrangedSubviews: [
            titleLabel,
            descriptionLabel,
            dateLabel
        ]
    ).then {
        $0.axis = .vertical
        $0.spacing = 5
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.font = .preferredFont(for: .title2, weight: .bold)
        $0.text = "타이틀레이블"
    }
    
    private lazy var descriptionLabel = UILabel().then {
        $0.font = .preferredFont(for: .title3, weight: .bold)
        $0.numberOfLines = 3
        $0.textColor = .gray
        $0.text = "데스크립션레이블 데스크립션레이블 데스크립션레이블 데스크립션레이블 데스크립션레이블 데스크립션레이블 데스크립션레이블 데스크립션레이블 데스크립션레이블 데스크립션레이블 데스크립션레이블 데스크립션레이블 데스크립션레이블 데스크립션레이블 데스크립션레이블 데스크립션레이블 데스크립션레이블"
    }
    
    private lazy var dateLabel = UILabel().then {
        $0.font = .preferredFont(for: .headline, weight: .bold)
        $0.text = "데이트레이블"
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUILayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUILayout() {
        contentView.addSubview(baseCellStackView)
        baseCellStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
    }
}
