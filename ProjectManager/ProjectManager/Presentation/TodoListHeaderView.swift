//
//  TodoListHeaderView.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/10.
//

import UIKit

final class TodoListHeaderView: UIView {
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, countLabel])
        stackView.spacing = 8
        
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .largeTitle)
        
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
        super.init(frame: .zero)
        configureLayout()
        titleLabel.text = title
        self.backgroundColor = .systemGray6
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        self.addSubview(labelStackView)
        labelStackView.snp.makeConstraints { make in
            make.top.leading.bottom.equalTo(self).inset(8)
            make.width.lessThanOrEqualTo(self.snp.width).multipliedBy(0.9)
        }
        
        countLabel.snp.makeConstraints { make in
            make.width.equalTo(countLabel.snp.height)
            make.height.equalTo(30)
        }
    }
}

extension TodoListHeaderView {
    func setCountText(to count: String) {
        countLabel.text = count
    }
}
