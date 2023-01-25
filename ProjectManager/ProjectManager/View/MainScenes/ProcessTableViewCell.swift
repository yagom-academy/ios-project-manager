//
//  ProcessTableViewCell.swift
//  ProjectManager
//
//  Created by Kyo on 2023/01/12.
//

import UIKit

final class ProcessTableViewCell: UITableViewCell {
    private enum UIConstant {
        static let titleNumberLine = 1
        static let contentNumberLine = 3
        static let stackViewSpacing = 5.0
        static let topValue = 10.0
        static let bottomValue = -10.0
        static let leadingValue = 10.0
        static let trailingValue = -10.0
    }
    
    private let titleLabel = UILabel(fontStyle: .title2)
    private let contentLabel = UILabel(fontStyle: .body)
    private let dateLabel = UILabel(fontStyle: .body)
    
    private var viewModel: CellViewModel?
    
    private lazy var stackView = UIStackView(
        views: [titleLabel, contentLabel, dateLabel],
        axis: .vertical,
        alignment: .leading,
        distribution: .fill,
        spacing: UIConstant.stackViewSpacing
    )
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupLabel()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = .white
        contentView.bounds = contentView.bounds.inset(
            by: UIEdgeInsets(top: .zero, left: .zero, bottom: 5, right: .zero)
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        [titleLabel, contentLabel, dateLabel].forEach {
            $0.text = ""
        }
    }
    
    private func setupBind() {
        viewModel?.bindData { [weak self] data in
            self?.titleLabel.text = data.title
            self?.contentLabel.text = data.content
            self?.dateLabel.text = data.convertDeadline
            self?.checkDeadLine()
        }
    }
    
    private func checkDeadLine() {
        guard viewModel?.checkOverDeadLine() != true else {
            dateLabel.textColor = .red
            return
        }
    }
    
    func setupViewModel(_ viewModel: CellViewModel, _ data: Plan) {
        self.viewModel = viewModel
        setupBind()
        self.viewModel?.setupData(data)
    }
}

// MARK: - UI Configuration
extension ProcessTableViewCell {
    private func setupView() {
        backgroundColor = .systemGray5
        contentView.addSubview(stackView)
    }
    
    private func setupLabel() {
        titleLabel.numberOfLines = UIConstant.titleNumberLine
        contentLabel.numberOfLines = UIConstant.contentNumberLine
    }
    
    private func setupConstraint() {
        let safeArea = contentView.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(
                equalTo: safeArea.topAnchor,
                constant: UIConstant.topValue
            ),
            stackView.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor,
                constant: UIConstant.leadingValue
            ),
            stackView.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor,
                constant: UIConstant.trailingValue
            ),
            stackView.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor,
                constant: UIConstant.bottomValue
            )
        ])
    }
}

extension ProcessTableViewCell: Identifierable { }
