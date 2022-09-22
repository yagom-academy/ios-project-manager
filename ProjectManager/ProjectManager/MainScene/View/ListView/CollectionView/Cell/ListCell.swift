//
//  ListCell.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/09.
//

import UIKit

final class ListCell: UICollectionViewCell {
    
    // MARK: - UIComponents
    private let verticalStackView = DefaultStackViewBuilder()
        .useAutoLayout()
        .setAxis(.vertical)
        .setDistribution(.fill)
        .setAlignment(.fill)
        .setSpacing(5)
        .stackView
    
    let titleLabel = DefaultLabelBuilder()
        .useAutoLayout()
        .setPreferredFont(.title3)
        .label
    
    let bodyLabel = DefaultLabelBuilder()
        .useAutoLayout()
        .setPreferredFont(.body)
        .numberOfLines(3)
        .setTextColor(with: .systemGray)
        .label
    
    let dateLabel = DefaultLabelBuilder()
        .useAutoLayout()
        .setPreferredFont(.footnote)
        .label
    
    private let viewModel = ListCellViewModel()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialView()
        setupVerticalStackView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Methods
    private func setupInitialView() {
        backgroundColor = .white
    }
    
    private func setupVerticalStackView() {
        contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(bodyLabel)
        verticalStackView.addArrangedSubview(dateLabel)
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 10
            ),
            verticalStackView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -10
            ),
            verticalStackView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 20
            ),
            verticalStackView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -20
            )
        ])
    }
    
    func setup(with model: Todo) {
        viewModel.setupData(in: self, with: model)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        bodyLabel.text = nil
        dateLabel.text = nil
        dateLabel.textColor = nil
    }
    
    override func draw(_ rect: CGRect) {
        let separator = UIBezierPath()
        separator.move(to: CGPoint(x: 0, y: bounds.maxY))
        separator.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        separator.lineWidth = 2
        UIColor.lightGray.setStroke()
        separator.stroke()
        separator.close()
    }
}
