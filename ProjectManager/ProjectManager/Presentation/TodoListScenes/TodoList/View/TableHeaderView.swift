//
//  TableHeaderView.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import UIKit

import SnapKit

final class TableHeaderView: UIView {
    private let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        
        return stackView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.setContentHuggingPriority(.required, for: .horizontal)
        
        return label
    }()
    
    let todoListCountLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.text = "0"
        label.textAlignment = .center
        label.layer.cornerRadius = 15
        label.clipsToBounds = true
        label.backgroundColor = .label
        label.textColor = .systemBackground
        
        return label
    }()
    
    init(title: String) {
        self.titleLabel.text = title
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubviews()
        setupConstraint()
        setupView()
    }
    
    private func addSubviews() {
        addSubview(titleStackView)
        titleStackView.addArrangeSubviews(titleLabel, todoListCountLabel)
    }
    
    private func setupConstraint() {
        titleStackView.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview().inset(10)
            $0.trailing.lessThanOrEqualToSuperview()
        }
        
        todoListCountLabel.snp.makeConstraints {
            $0.width.equalTo(todoListCountLabel.snp.height)
        }
    }
    
    private func setupView() {
        backgroundColor = .systemGray6
    }
}
