//
//  TodoTableViewCell.swift
//  ProjectManager
//
//  Created by 조민호 on 2022/07/06.
//

import UIKit

import SnapKit

final class TodoTableViewCell: UITableViewCell {
    private let todoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 5
        
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .secondaryLabel
        label.numberOfLines = 3
        return label
    }()
    
    private let deadLineLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0))
    }
    
    private func setup() {
        addSubviews()
        setupConstraint()
        setupView()
    }
    
    private func addSubviews() {
        contentView.addSubview(todoStackView)
        todoStackView.addArrangeSubviews(titleLabel, contentLabel, deadLineLabel)
    }
    
    private func setupConstraint() {
        todoStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func setupView() {
        backgroundColor = .systemGray6
        contentView.backgroundColor = .systemBackground
    }
    
    func setupData(with data: TodoListModel) {
        titleLabel.text = data.title
        contentLabel.text = data.content
        deadLineLabel.text = data.deadLine.formattedString
    }
}
